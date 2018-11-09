//
//  Colors.swift
//  Gleam
//
//  Created by Каратаев Алексей on 09.11.2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import UIKit

// MARK: - implement project colors

extension UIColor {
    
    static var assessmentColor: UIColor {
        return UIColor(red: 187 / 255, green: 187 / 255, blue: 187 / 255, alpha: 1)
    }
    
    static var lowIndicatorColor: UIColor {
        return UIColor (red: 156 / 255, green: 238 / 255, blue: 106 / 255, alpha: 1)
    }

    static var mediumIndicatorColor: UIColor {
        return UIColor (red: 18 / 255, green: 204 / 255, blue: 255 / 255, alpha: 1)
    }

    static var highIndicatorColor: UIColor {
        return UIColor(red: 238 / 255, green: 221 / 255, blue: 106 / 255, alpha: 1)
    }
    
    static var diagnosisLabelColor: UIColor {
        return UIColor(red: 102 / 255, green: 102 / 255, blue: 102 / 255, alpha: 1)
    }
    
    static var baseButtonColor: UIColor {
        return UIColor (red: 17 / 255, green: 181 / 255, blue: 226 / 255, alpha: 0.7)
    }
    
    static var spotButtonColor: UIColor {
        return UIColor (red: 18 / 255, green: 204 / 255, blue: 255 / 255, alpha: 1)
    }
}

