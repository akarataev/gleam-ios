//
//  ScreeningViewControllerStyles.swift
//  Gleam
//
//  Created by Каратаев Алексей on 09.11.2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

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


// MARK: - implement styles for StatusIndicatorView

extension StyleWrapper where Element: StatusIndicatorView {
    
    static func statusPanelLayoutStyle(at view: UIView) -> StyleWrapper {
        return .wrap { statusPanel in
            statusPanel.snp.makeConstraints { make in
                make.leading.equalTo(view.snp.leading)
                make.trailing.equalTo(view.snp.trailing)
                make.bottom.equalTo(view.snp.bottom)
                make.height.equalTo(112)
            }
        }
    }
}


// MARK: - implement styles for CircleIndicatorVeiw

extension StyleWrapper where Element: CircleIndicatorView {
    
    static func circleIndicatorStyle(color: UIColor) -> StyleWrapper {
        return .wrap { circleIndicator in circleIndicator.backgroundColor = color }
    }
    
    static func circleIndicatorLayoutStyle(at view: UIView) -> StyleWrapper {
        return .wrap { circleIndicator in
            circleIndicator.snp.makeConstraints { make in
                make.left.equalTo(view.snp.left)
                make.centerY.equalTo(view.snp.centerY)
                make.width.equalTo(16)
                make.height.equalTo(16)
            }
        }
    }
    
    static var spotButtonViewStyle: StyleWrapper {
        return .wrap { spotButtonView in spotButtonView.backgroundColor = .spotButtonColor }
    }
    
    static func spotButtonViewLayoutStyle(at view: UIView) -> StyleWrapper {
        return .wrap { spotButtonView in
            spotButtonView.snp.makeConstraints { make in
                make.centerX.equalTo(view.snp.centerX)
                make.centerY.equalTo(view.snp.centerY)
                make.width.equalTo(56)
                make.height.equalTo(56)
            }
        }
    }
    
    static var baseButtonViewStyle: StyleWrapper {
        return .wrap { baseButtonView in baseButtonView.backgroundColor = .baseButtonColor }
    }
    
    static func baseButtonViewLayoutStyle(at view: UIView) -> StyleWrapper {
        return .wrap { baseButtonView in
            baseButtonView.snp.makeConstraints { make in
                make.centerX.equalTo(view.snp.centerX)
                make.centerY.equalTo(view.snp.centerY)
                make.width.equalTo(88)
                make.height.equalTo(88)
            }
        }
    }
}


// MARK: - implement styles for UILabel

extension StyleWrapper where Element: UILabel {
    
    static var descriptionLabelStyle: StyleWrapper {
        return .wrap { descriptionLabel in
            descriptionLabel.text = "Your assessment is"
            descriptionLabel.font = .assassmentFont
            descriptionLabel.textColor = .assessmentColor
        }
    }
    
    static func descriptionLabelLayoutStyle(at view: UIView) -> StyleWrapper {
        return .wrap { descriptionLabel in
            descriptionLabel.snp.makeConstraints { make in
                make.centerX.equalTo(view.snp.centerX)
                make.top.equalTo(view.snp.top).offset(24)
            }
        }
    }
}


// MARK: - implement styles for NVActivityIndicatorView

extension StyleWrapper where Element: NVActivityIndicatorView {
    
    static func statusIndicatorLayoutStyle(view: UIView, label: UILabel) -> StyleWrapper {
        return .wrap { statusIndicator in
            statusIndicator.snp.makeConstraints { make in
                make.width.equalTo(256)
                make.height.equalTo(64)
                make.centerX.equalTo(view.snp.centerX)
                make.top.equalTo(label.snp.top).offset(16)
            }
        }
    }
}


// MARK: - implement styles for DiagnosisLabel

extension StyleWrapper where Element: UILabel {
    
    static func diagnosisLabelStyle(_ diagnosis: String) -> StyleWrapper {
        return .wrap { diagnosisLabel in
            diagnosisLabel.text = diagnosis
            diagnosisLabel.font = .diagnosisFont
            diagnosisLabel.textColor = .diagnosisLabelColor
        }
    }
    
    
    static func diagnosisLabelLayoutStyle(at view: UIView, indicator: UIView) -> StyleWrapper {
        return .wrap { diagnosisLabel in
            diagnosisLabel.snp.makeConstraints { make in
                make.centerY.equalTo(view.snp.centerY)
                make.left.equalTo(indicator.snp.right).offset(16)
            }
        }
    }
}


// MARK: - implement styles for DiagnosisIndicatorView

extension StyleWrapper where Element: DiagnosisIndicatorView {
    
    static func diagnosisIndicatorLayoutStyle(at view: UIView, width: Float) -> StyleWrapper {
        return .wrap { diagnosisIndicator in
            diagnosisIndicator.snp.makeConstraints { make in
                make.centerX.equalTo(view.snp.centerX)
                make.bottom.equalTo(view.snp.bottom).offset(-24)
                make.width.equalTo(width)
                make.height.equalTo(38)
            }
        }
    }
}


// MARK: - implement styles for CaptureButton

extension StyleWrapper where Element: CaptureButton  {
    
    static var captureButtonStyle: StyleWrapper {
        return .wrap { captureButton in
            captureButton.frame = CGRect (
                origin: .zero, size: CGSize(width: 88, height: 88)
            )
        }
    }
    
    static func captureButtonLayoutStyle(at view: UIView) -> StyleWrapper {
        return .wrap { captureButton in
            captureButton.snp.makeConstraints { make in
                make.centerX.equalTo(view.snp.centerX)
                make.bottom.equalTo(view.snp.top).offset(-71)
                make.width.equalTo(88)
                make.height.equalTo(88)
            }
        }
    }
}
