//
//  VideoCapturePreviewLayer.swift
//  Gleam
//
//  Created by Каратаев Алексей on 09.11.2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import AVKit

@objc class VideoCapturePreviewLayer: UIView {
    
    @objc var captureSession: VideoCaptureSession!
    @objc var previewLayer: AVCaptureVideoPreviewLayer!
}


// MARK: - implement end-points for manage capture session

extension VideoCapturePreviewLayer {
    
    func startCapture() {
        self.previewLayer.frame = frame
        self.captureSession.startRunning()
    }
    
    func stopCapture() {
        self.captureSession.stopRunning()
    }
}


// MARK: - implement setup captured video on CALayer

extension VideoCapturePreviewLayer {
    
    @objc func prepareForCaptureVideo() {
        self.previewLayer.videoGravity = .resizeAspectFill
        self.layer.addSublayer(previewLayer)
    }
}

