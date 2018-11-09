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
    @objc var screeningView: VideoCapturePreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyStyles()
        output.viewIsReady()
    }

    func setupInitialState() {
        self.screeningView.startCapture()
    }
}


// MARK: - implement style applying

extension ScreeningViewController {

    func applyStyles() {
        self.applyScreeningViewStyles()
    }

    func applyScreeningViewStyles() {
        self.view.addSubview(screeningView)
        self.screeningView.apply (
            .screeningViewStyle,
            .screeningViewLayoutStyle(at: view)
        )
    }
}
