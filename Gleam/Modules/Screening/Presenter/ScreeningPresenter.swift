//
//  ScreeningScreeningPresenter.swift
//  Gleam
//
//  Created by Каратаев Алексей on 09/11/2018.
//  Copyright © 2018 Apptolab. All rights reserved.
//

import Foundation

class ScreeningPresenter: NSObject, ScreeningModuleInput, ScreeningViewOutput, ScreeningInteractorOutput {

    @objc weak var view: ScreeningViewInput!
    @objc var interactor: ScreeningInteractorInput!
    @objc var router: ScreeningRouterInput!

    func viewIsReady() {
        view.setupInitialState()
    }
}


// MARK: - Processing of user actions

extension ScreeningPresenter {

}


// MARK: - Prerouting section

extension ScreeningPresenter {

}
