//
//  OnboardingModel.swift
//  Gleam
//
//  Created by albert on 09/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import UIKit

enum OnboardingButtonState: String {
    case next = "Next step"
    case start = "Start using"
}

struct OnboardingModel: Model {
    var onboardingImage: UIImage
    var onboardingTitle: String
    var onboardingDescription: String
    var onboardingButtonState: OnboardingButtonState
}
