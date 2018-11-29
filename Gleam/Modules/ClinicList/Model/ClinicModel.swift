//
//  ClinicModel.swift
//  Gleam
//
//  Created by albert on 09/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation

struct ClinicModel: Codable, Model {
    
    var clinicId: Int
    var title: String
    var type: String
    var address: String
    var rating: Double
    var isOpen: Bool
    var opensAt: Int?
    var position: [Double]
    var distance: Double?
    
    enum CodingKeys: String, CodingKey {
        case clinicId = "id"
        case title = "name"
        case type = "type"
        case address
        case rating
        case isOpen
        case opensAt
        case position
        case distance
    }
}
