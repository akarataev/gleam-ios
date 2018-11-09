//
//  ClinicViewModel.swift
//  Gleam
//
//  Created by albert on 09/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import UIKit

struct ClinicViewModel {
    private let model: ClinicModel
    
    init(model: ClinicModel) {
        self.model = model
    }
    
    var title: String {
        return model.title
    }
    
    var type: String {
        return model.type
    }
    
    var distance: String {
        return "1 km" // HARDCODED
    }
    
    var address: String {
        return "HARDCODED ADDRESS"
    }
    
    var statusColor: UIColor {
        if model.isOpen {
            return UIColor.Gleam.lightMossGreen
        } else {
            return UIColor.Gleam.pinkishTan
        }
    }
    
    var statusTitle: String {
        if let opensAt = model.opensAt {
            let date = Date(timeIntervalSince1970: TimeInterval(opensAt))
            print(date)
        }
        if model.isOpen {
            return "Open around the clock"
        } else {
            return "Closed until tomorrow"
        }
    }
    
    var rating: CGFloat {
        return CGFloat(model.rating)
    }
}
