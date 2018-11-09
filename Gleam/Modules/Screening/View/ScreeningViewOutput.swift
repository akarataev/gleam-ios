//
//  ScreeningScreeningViewOutput.swift
//  Gleam
//
//  Created by Каратаев Алексей on 09/11/2018.
//  Copyright © 2018 Apptolab. All rights reserved.
//

import UIKit
import Foundation

@objc protocol ScreeningViewOutput {
    func viewIsReady()
    func viewIsPrepareToSegue(segue: UIStoryboardSegue)
}


// MARK: - setup ScreeningPresenter for routing

extension ScreeningPresenter {

    func viewIsPrepareToSegue(segue: UIStoryboardSegue) {
        router.passData (
            segue: segue
        )
    }
}
