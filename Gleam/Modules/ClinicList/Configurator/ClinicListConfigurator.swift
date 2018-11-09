//
//  ClinicListConfigurator.swift
//  Gleam
//
//  Created by albert on 09/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation

class ClinicListConfigurator {
    
    static func configure(_ viewController: ClinicListViewController) {
        let interactor = ClinicListInteractor()
        let presenter = ClinicListPresenter(interactor: interactor)
        viewController.output = presenter
        interactor.output = presenter
        presenter.view = viewController
    }
}
