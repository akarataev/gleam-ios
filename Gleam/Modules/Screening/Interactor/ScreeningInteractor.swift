//
//  ScreeningScreeningInteractor.swift
//  Gleam
//
//  Created by Каратаев Алексей on 09/11/2018.
//  Copyright © 2018 Apptolab. All rights reserved.
//

import Foundation
import AVKit

class ScreeningInteractor: NSObject, ScreeningInteractorInput {
    
    @objc weak var output: ScreeningInteractorOutput!
    
    var imagesNumber: Int = 0
    var capturedData: Array<(String, Float)> = []
    
    
    @objc weak var classificator: SkinCancerClassificator! {
        didSet { classificator.delegate = self }
    }
    
    @objc weak var captureSession: VideoCaptureSession! {
        didSet { captureSession.addVideoBufferOutput(delegate: self) }
    }
    
}


// MARK: - implement process of classification

extension ScreeningInteractor {
    
    func provideResultsOfClassification(mode: CaptureMode) {
        self.imagesNumber = 0
        self.capturedData = []
        self.setNumberOfCapturedImages(by: mode)
    }
    
    func setNumberOfCapturedImages(by mode: CaptureMode) {
        self.imagesNumber = mode.rawValue
    }
    
    func evaluateDiagnosis() {
        let benign = getPredictedScore(by: .benign)
        let malignant = getPredictedScore(by: .malignant)
        output.presentResultOfClassification (
            result: malignant > benign ? .high: .low
        )
    }
    
    func getPredictedScore(by label: ClassLabel) -> Float {
        return self.capturedData.filter { $0.0 == label.rawValue }
            .reduce(0) { $0 + $1.1 } / Float(capturedData.count)
    }
}


// MARK: - implement skin cancer classification delegate

extension ScreeningInteractor: SkinCancerClassificatorDelegate {
    
    func classificatorFinishedWith(stats: Array<(String, Float)>) {
        stats.forEach { self.capturedData.append($0) }
    }
}


// MARK: - implement capture session video buffer delegate

extension ScreeningInteractor: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        self.provideClassificationRequest {
            self.classificator.startClassification (sampleBuffer: sampleBuffer)
        }
    }
    
    func provideClassificationRequest(classificationRequest: () -> Void) {
        guard self.imagesNumber > 0 else { return }
        classificationRequest(); self.imagesNumber -= 1
        if self.imagesNumber == 0 { evaluateDiagnosis() }
    }
}
