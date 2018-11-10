//
//  UserFlowConfigurator.swift
//  Gleam
//
//  Created by albert on 10/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation

class UserFlowConfigurator {
    static func configure(currentState: UserFormState, userData: UserFlowData) -> UserFlowViewController {
        let viewController = UserFlowViewController()
        let interactor = UserFlowInteractor()
        let presenter = UserFlowPresenter(interactor: interactor, currentState: currentState, userData: userData)
        viewController.output = presenter
        interactor.output = presenter
        presenter.view = viewController
        return viewController
    }
}
