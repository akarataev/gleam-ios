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
    
    
    @objc var classificator: SkinCancerClassificator! {
        didSet { classificator.delegate = self }
    }
    
    @objc var captureSession: VideoCaptureSession! {
        didSet { captureSession.addVideoBufferOutput(delegate: self) }
    }
    
}


// MARK: - implement skin cancer classification delegate

extension ScreeningInteractor: SkinCancerClassificatorDelegate {
    
    func classificatorFinishedWith(stats: Array<(String, Float)>) {
        
    }
}


// MARK: - implement capture session video buffer delegate

extension ScreeningInteractor: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
    }
}
