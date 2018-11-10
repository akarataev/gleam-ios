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
        guard let distance = model.distance else {
            return "-"
        }
        let roudedValue = Double(round(distance * 100) / 100)
        return "\(roudedValue) km"
    }
    
    var address: String {
        return model.address
    }
    
    var statusColor: UIColor {
        if model.isOpen {
            return UIColor.Gleam.lightMossGreen
        } else {
            return UIColor.Gleam.pinkishTan
        }
    }
    
    var statusTitle: String {
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
