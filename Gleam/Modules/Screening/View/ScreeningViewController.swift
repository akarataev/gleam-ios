//
//  ScreeningScreeningViewController.swift
//  Gleam
//
//  Created by Каратаев Алексей on 09/11/2018.
//  Copyright © 2018 Apptolab. All rights reserved.
//

import UIKit

class ScreeningViewController: UIViewController, ScreeningViewInput {

    @objc var output: ScreeningViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    func setupInitialState() {

    }
}
