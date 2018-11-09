//
//  DiagnosisIndicatorView.swift
//  Gleam
//
//  Created by Каратаев Алексей on 09.11.2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import UIKit

class DiagnosisIndicatorView: UIView {
    
    var circleIdicator: CircleIndicatorView!
    var diagnosisLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


// MARK: - applying indicator styles

extension DiagnosisIndicatorView {
    
    func applyStyles(diagnosis: String, color: UIColor) {
        self.applyIndicatorStyles(color)
        self.applyLabelStyles(diagnosis)
    }
    
    func applyIndicatorStyles(_ color: UIColor) {
        self.circleIdicator = CircleIndicatorView.regular
        self.addSubview(circleIdicator)
        self.circleIdicator.apply (
            .circleIndicatorStyle(color: color),
            .circleIndicatorLayoutStyle(at: self)
        )
    }
    
    func applyLabelStyles(_ diagnosis: String) {
        self.diagnosisLabel = UILabel()
        self.addSubview(diagnosisLabel)
        self.diagnosisLabel.apply (
            .diagnosisLabelStyle(diagnosis),
            .diagnosisLabelLayoutStyle(at: self, indicator: circleIdicator)
        )
    }
}

