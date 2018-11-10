//
//  FlowCoordinator.swift
//  Gleam
//
//  Created by albert on 10/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import UIKit

class FlowCoordinator {
    static func getInitialViewController() -> UIViewController {
        let identifier: String
        if UserSettings.skipOnboarding {
            identifier = "ClinicListViewController"
        } else {
            identifier = "OnboardingViewController"
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: identifier)
        return initialViewController
    }
}
