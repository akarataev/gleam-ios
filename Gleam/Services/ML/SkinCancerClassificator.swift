//
//  SkinCancerClassificator.swift
//  Gleam
//
//  Created by Каратаев Алексей on 10.11.2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import Vision
import CoreML
import AVKit

// MARK: - implement VGG16 model management

@objc class SkinCancerClassificator: NSObject {
    
    var delegate: SkinCancerClassificatorDelegate?
    
    private lazy var model: VNCoreMLModel = {
        try! VNCoreMLModel(for: FTVGG16().model)
    }()
    
    private lazy var classificationRequest: VNCoreMLRequest = {
        VNCoreMLRequest(model: self.model) { request, error in
            self.didFinishedClassification(with: request.results)
        }
    }()
}


// MARK: - implement handlers for classification process


private extension SkinCancerClassificator {
    
    func didFinishedClassification(with results: Array<Any>?) {
        (results as? [VNClassificationObservation]).map {
            self.didFinishedByClass(with: $0)
        }
    }
    
    func didFinishedByClass(with stats: Array<VNClassificationObservation>) {
        self.delegate?.classificatorFinishedWith (
            stats: stats.map { ($0.identifier, confidence: $0.confidence) }
        )
    }
}


// MARK: - implement run classification process

extension SkinCancerClassificator {
    
    func startClassification(sampleBuffer: CMSampleBuffer) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        guard let preprocessImage = CIImage(cvPixelBuffer: pixelBuffer).preprocess else { return }
        try? VNImageRequestHandler(cgImage: preprocessImage).perform([self.classificationRequest])
    }
}
