//
//  VideoCaptureSession.swift
//  Gleam
//
//  Created by Каратаев Алексей on 09.11.2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import AVKit

@objc class VideoCaptureSession: AVCaptureSession {
    
    override init() {
        super.init()
        self.setupInputDevice()
    }
}


// MARK: - implement video capture session sertup

private extension VideoCaptureSession {
    
    func setupInputDevice() {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let deviceInput = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        self.addInput(deviceInput)
        self.setupSessionFrameRate(captureDevice)
    }
    
    func setupSessionFrameRate(_ captureDevice: AVCaptureDevice) {
        if let minDuration = getDeviceMinFrameDuration(captureDevice) {
            captureDevice.activeVideoMaxFrameDuration = minDuration
        }
    }
    
    func getDeviceMinFrameDuration(_ captureDevice: AVCaptureDevice) -> CMTime? {
        return captureDevice.activeFormat.videoSupportedFrameRateRanges
            .map { $0.minFrameDuration }.min(by: {$0 < $1 })
    }
}


// MARK: - implement add delegate for module interactor

extension VideoCaptureSession {
    
    func addVideoBufferOutput(delegate: AVCaptureVideoDataOutputSampleBufferDelegate) {
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(delegate, queue: DispatchQueue(label: "videoBuffer"))
        self.addOutput(dataOutput)
    }
}
