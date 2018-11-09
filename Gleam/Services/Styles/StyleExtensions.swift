//
//  StyleExtensions.swift
//  Gleam
//
//  Created by albert on 09/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    struct Gleam {
        static let brownishGrey = UIColor(rgb: 0x666666)
        static let neonBlue = UIColor(rgb: 0x12ccff)
        static let veryLightPink = UIColor(rgb: 0xe4e4e4)
        static let blueGrey = UIColor(rgb: 0x8E8E93)
        static let pinkishTan = UIColor(rgb: 0xee956a)
        static let lightMossGreen = UIColor(rgb: 0x8cd572)
        static let veryLightPinkTwo = UIColor(rgb: 0xbbbbbb)
        static let separatorColor = UIColor(rgb: 0xF9F8FA)
    }
}


extension UISearchBar {
    func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let textField = (svs.first { $0 is UITextField }) as? UITextField else { return }
        textField.textColor = color
    }
}


extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UINavigationController {
    override open var childViewControllerForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
}

