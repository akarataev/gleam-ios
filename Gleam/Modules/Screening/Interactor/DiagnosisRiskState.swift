//
//  DiagnosisRiskState.swift
//  Gleam
//
//  Created by Каратаев Алексей on 09.11.2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import UIKit

@objc enum DiagnosisRiskState: Int {
    
    case low
    case medium
    case high
    
    var width: Float {
        switch self {
        case .low:
            return 175
        case .medium:
            return 230
        case .high:
            return 182
        }
    }
    
    var description: String {
        switch self {
        case .low:
            return "LOW RISK"
        case .medium:
            return "MEDIUM RISK"
        case .high:
            return "HIGH RISK"
        }
    }
    
    var color: UIColor {
        switch self {
        case .low:
            return .lowIndicatorColor
        case .medium:
            return .mediumIndicatorColor
        case .high:
            return .highIndicatorColor
        }
    }
}
