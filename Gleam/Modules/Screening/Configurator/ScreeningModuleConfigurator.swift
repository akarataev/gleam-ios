//
//  ScreeningScreeningModuleConfigurator.swift
//  Gleam
//
//  Created by Каратаев Алексей on 09/11/2018.
//  Copyright © 2018 Apptolab. All rights reserved.
//

import UIKit
import Typhoon

class ScreeningModuleConfigurator: TyphoonAssembly {

    @objc public dynamic func configureScreeningViewController() -> Any {
        return TyphoonDefinition.withClass(ScreeningViewController.self) {
            definition in
            definition?.injectProperty(
                Selector(("output")),
                with: self.configureScreeningPresenter()
            )
        }
    }

    @objc public dynamic func configureScreeningPresenter() -> Any {
        return TyphoonDefinition.withClass(ScreeningPresenter.self) {
            definition in
            definition?.injectProperty(
                #selector(getter: UITouch.view),
                with: self.configureScreeningViewController()
            )
            definition?.injectProperty(
                Selector(("interactor")),
                with: self.configureScreeningInteractor()
            )
            definition?.injectProperty(
                Selector(("router")),
                with: self.configureScreeningRouter()
            )
        }
    }

    @objc public dynamic func configureScreeningRouter() -> Any {
        return TyphoonDefinition.withClass(ScreeningRouter.self)
    }

    @objc public dynamic func configureScreeningInteractor() -> Any {
        return TyphoonDefinition.withClass(ScreeningInteractor.self) {
            definition in
            definition?.injectProperty(
                Selector(("output")),
                with: self.configureScreeningPresenter()
            )
        }
    }
}
