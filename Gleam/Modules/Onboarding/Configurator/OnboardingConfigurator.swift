//
//  OnboardingConfigurator.swift
//  Gleam
//
//  Created by albert on 09/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation

class OnboardingConfigurator {
    static func configure(_ viewController: OnboardingViewController) {
        let presenter = OnboardingPresenter()
        viewController.output = presenter
        presenter.view = viewController
    }
}
