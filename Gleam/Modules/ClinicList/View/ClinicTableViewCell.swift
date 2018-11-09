//
//  ClinicTableViewCell.swift
//  Gleam
//
//  Created by albert on 09/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import UIKit
import HCSStarRatingView

class ClinicTableViewCell: UITableViewCell, CollectionSetupable {
    
    private lazy var clinicTitleLabel = createClinicTitleLabel()
    private lazy var clinicTypeLabel = createClinicTypeLabel()
    private lazy var clinicAddressLabel = createClinicAddressLabel()
    private lazy var clinicDistanceLabel = createClinicDistanceLabel()
    private lazy var clinicOpenStatusLabel = createClinicOpenStatusLabel()
    private lazy var clinicOpenStatusView = createClinicOpenStatusView()
    private lazy var clinicRateView = createClinicRateView()
    private lazy var stackView = createStackView()
    private lazy var separatorView = createSeparatorView()
    
    func setup(with model: ClinicModel) {
        let viewModel = ClinicViewModel(model: model)
        _ = separatorView
        clinicTitleLabel.text = viewModel.title
        clinicTypeLabel.text = viewModel.type
        clinicAddressLabel.text = viewModel.address
        clinicDistanceLabel.text = viewModel.distance
        clinicOpenStatusLabel.text = viewModel.statusTitle
        clinicOpenStatusView.backgroundColor = viewModel.statusColor
        clinicRateView.value = viewModel.rating
    }
}

private extension ClinicTableViewCell {
    
    func createClinicTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = UIColor.Gleam.brownishGrey
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(24)
        }
        return label
    }
    
    func createClinicTypeLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.Gleam.veryLightPinkTwo
        return label
    }
    
    func createClinicDistanceLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.Gleam.veryLightPinkTwo
        return label
    }
    
    func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(clinicTypeLabel)
        stackView.addArrangedSubview(clinicDistanceLabel)
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(clinicTitleLabel.snp.bottom).offset(8)
            make.leading.equalTo(clinicTitleLabel)
            make.trailing.equalTo(clinicRateView)
        }
        return stackView
    }
    
    func createClinicAddressLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        label.numberOfLines = 2
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(8)
            make.leading.equalTo(stackView)
            make.trailing.equalTo(stackView)
        }
        return label
    }
    
    func createClinicOpenStatusLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(clinicAddressLabel.snp.bottom).offset(8)
            make.leading.equalTo(clinicAddressLabel)
        }
        return label
    }
    
    func createClinicOpenStatusView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 5
        addSubview(view)
        
        view.snp.makeConstraints { make in
            make.left.equalTo(clinicOpenStatusLabel.snp.right).offset(8)
            make.centerY.equalTo(clinicOpenStatusLabel)
            make.height.equalTo(10)
            make.width.equalTo(10)
        }
        return view
    }
    
    func createClinicRateView() -> HCSStarRatingView {
        let rateView = HCSStarRatingView()
        rateView.emptyStarImage = #imageLiteral(resourceName: "emptyStar")
        rateView.filledStarImage = #imageLiteral(resourceName: "filledStar")
        addSubview(rateView)
        
        rateView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(14)
            make.width.equalTo(72)
        }
        return rateView
    }
    
    func createSeparatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.Gleam.separatorColor
        addSubview(view)
        
        view.snp.makeConstraints { make in
            make.top.equalTo(clinicOpenStatusLabel.snp.bottom).offset(16)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(8)
        }
        return view
    }
}
