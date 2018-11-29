//
//  UserFormState.swift
//  Gleam
//
//  Created by albert on 10/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation

enum UserFormState {
    
    case name
    case number
    case email
    
    func getTitle() -> String {
        switch self {
        case .name:
            return "Your name"
        case .number:
            return "Your number"
        case .email:
            return "Your email"
        }
    }
    
    func getPlaceholder() -> String {
        switch self {
        case .name:
            return "Enter your name"
        case .number:
            return "Enter your phone number"
        case .email:
            return "Enter your email"
        }
    }
    
    func getButtonTitle() -> String {
        switch self {
        case .name, .number:
            return "Next step"
        case .email:
            return "Make an appointment"
        }
    }
}
