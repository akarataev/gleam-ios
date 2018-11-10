//
//  ScreeningScreeningViewInput.swift
//  Gleam
//
//  Created by Каратаев Алексей on 09/11/2018.
//  Copyright © 2018 Apptolab. All rights reserved.
//

import UIKit
import Foundation

@objc protocol ScreeningViewInput: class {
    func setupInitialState()
    func displayDiagnosis(state: DiagnosisRiskState)
    func getSender() -> UIViewController
}


// MARK: - setup ScreeningViewController for routing

extension ScreeningViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        output.viewIsPrepareToSegue(segue: segue)
    }

    func getSender() -> UIViewController {
        return self
    }
}
