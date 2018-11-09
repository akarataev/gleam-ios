//
//  OnboardingCollectionViewCell.swift
//  Gleam
//
//  Created by albert on 09/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class OnboardingCollectionViewCell: UICollectionViewCell, CollectionSetupable {
    
    private lazy var onboardingImageView = self.createOnboardingImageView()
    private lazy var onboardingTitleLabel = self.createOnboardingTitleLabel()
    private lazy var onboardingDescriptionLabel = self.createOnboardingDescriptionLabel()
    private lazy var overlayView = self.createOverlayView()
    
    private var model: OnboardingModel!
    
    func setup(with model: OnboardingModel) {
        self.model = model
        onboardingImageView.image = model.onboardingImage
        onboardingTitleLabel.text = model.onboardingTitle
        onboardingDescriptionLabel.text = model.onboardingDescription
    }
    
    var buttonState: OnboardingButtonState {
        return model.onboardingButtonState
    }
    
    var buttonTtitle: String {
        return model.onboardingButtonState.rawValue
    }
}

private extension OnboardingCollectionViewCell {
    
    func createOnboardingImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        overlayView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make  in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(57)
            make.trailing.equalToSuperview().offset(-57)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        return imageView
    }
    
    func createOnboardingTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.Gleam.neonBlue
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(onboardingDescriptionLabel.snp.top).offset(-16)
            make.height.equalTo(41)
        }
        
        return label
    }
    
    func createOnboardingDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.Gleam.brownishGrey
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(80)
            make.bottom.equalToSuperview()
        }
        return label
    }
    
    func createOverlayView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        addSubview(view)
        
        view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(onboardingTitleLabel.snp.top)
        }
        return view
    }
}
