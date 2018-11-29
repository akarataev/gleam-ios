//
//  CaptureModeSegment.swift
//  Gleam
//
//  Created by Каратаев Алексей on 09.11.2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import UIKit

class CaptureModeSegment: UIStackView {
    
    var liveButton: UIButton!
    var photoButton: UIButton!
    var parentView: UIView!
    var marker: UIView!
    
    var mode: CaptureMode = .live
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupStackView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}


// MARK: - implement setup UIStackView

extension CaptureModeSegment {
    
    func setupStackView() {
        axis = .horizontal
        distribution = .equalSpacing
        alignment = .center
        spacing = 23
    }
}


// MARK: - implement capture segment mode

@objc enum CaptureMode: Int {
    case live = 10
    case photo = 1
}


// MARK: - implement style applying

extension CaptureModeSegment {
    
    func applyStyles() {
        self.applyLiveButtonStyles()
        self.applyPhotoButtonStyles()
        self.setButtonTitleLabel()
        self.addLiveButtonTarget()
        self.addPhotoButtonTarget()
        self.applyMarkerStyles()
        
    }
    
    func applyLiveButtonStyles() {
        self.liveButton = UIButton()
        self.addArrangedSubview(liveButton)
        self.liveButton.apply (
            .segmentButtonHighlightStyle
        )
    }
    
    func applyPhotoButtonStyles() {
        self.photoButton = UIButton()
        self.addArrangedSubview(photoButton)
        self.photoButton.apply (
            .segmentButtonRegularStyle
        )
    }
    
    func setButtonTitleLabel() {
        self.liveButton.setTitle("REAL", for: .normal)
        self.photoButton.setTitle("PHOTO", for: .normal)
    }
    
    func addLiveButtonTarget() {
        self.liveButton.addTarget (
            self,
            action: #selector(liveButtonDidTap(_:)),
            for: .touchUpInside
        )
    }
    
    func addPhotoButtonTarget() {
        self.photoButton.addTarget (
            self,
            action: #selector(photoButtonDidTap(_:)),
            for: .touchUpInside
        )
    }
    
    func applyMarkerStyles() {
        self.marker = UIView()
        self.addSubview(marker)
        self.marker.apply (
            .segmentMarkerStyle,
            .segmentMarkerLayoutStyle(at: parentView)
        )
    }
}


// MARK: - implement live and photo button handler's

extension CaptureModeSegment {
    
    @objc func liveButtonDidTap(_ sender: UIButton) {
        guard mode == .photo else { return }
        self.mode = .live
        
        self.photoButton.apply(.segmentButtonRegularStyle)
        self.liveButton.apply(.segmentButtonHighlightStyle)
        
        self.apply (
            .captureSegmentOffsetStyle (
                at: self.parentView, offset: 42
            )
        )
    }
    
    @objc func photoButtonDidTap(_ sender: UIButton) {
        guard mode == .live else { return }
        self.mode = .photo
        
        self.photoButton.apply(.segmentButtonHighlightStyle)
        self.liveButton.apply(.segmentButtonRegularStyle)
        
        self.apply (
            .captureSegmentOffsetStyle (
                at: self.parentView, offset: -32
            )
        )
    }
}
