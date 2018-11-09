//
//  ScreeningViewControllerStyles.swift
//  Gleam
//
//  Created by Каратаев Алексей on 09.11.2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import UIKit

// MARK: - implement styles for VideoCapturePreviewLayer

extension StyleWrapper where Element: VideoCapturePreviewLayer {
    
    static var screeningViewStyle: StyleWrapper {
        return .wrap { view in view.backgroundColor = .black }
    }
    
    static func screeningViewLayoutStyle(at view: UIView) -> StyleWrapper {
        return .wrap { screeningView in screeningView.frame = CGRect (
            origin: .zero, size: CGSize (
                width: view.frame.width, height: view.frame.height - 112)
            )
        }
    }
}
