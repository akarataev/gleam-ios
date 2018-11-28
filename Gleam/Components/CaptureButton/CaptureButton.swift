//
//  CaptureButton.swift
//  Gleam
//
//  Created by Каратаев Алексей on 09.11.2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import UIKit

class CaptureButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let buttonView = CircleIndicatorView.buttonView
        buttonView.isUserInteractionEnabled = false
        addSubview(buttonView)
        buttonView.apply(.baseButtonViewLayoutStyle(at: self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


// MARK: - implement pulse animation

extension CaptureButton {
    
    func startAnimation(for sender: CaptureButton, by mode: CaptureMode) {
        switch mode {
        case .live:
            self.repeatPulseAnimation(count: 9)
        case .photo:
            self.repeatPulseAnimation(count: 1)
        }
    }
    
    private func repeatPulseAnimation(count: Int) {
        guard count > 0 else { return }
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { finished in
            UIView.animate(withDuration: 0.3, animations: {
                self.transform = .identity
            }, completion: { finished in
                self.repeatPulseAnimation(count: count - 1)
            })
        })
    }
}

