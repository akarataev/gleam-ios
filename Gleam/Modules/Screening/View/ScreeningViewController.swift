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
    var statusPanel: StatusIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyStyles()
        output.viewIsReady()
    }

    func setupInitialState() {
        self.screeningView.startCapture()
        self.statusPanel.indicate()
    }
}


// MARK: - implement style applying

extension ScreeningViewController {

    func applyStyles() {
        self.applyScreeningViewStyles()
        self.applyStatusPanelStyles()
    }

    func applyScreeningViewStyles() {
        self.view.addSubview(screeningView)
        self.screeningView.apply (
            .screeningViewStyle,
            .screeningViewLayoutStyle(at: view)
        )
    }
    
    func applyStatusPanelStyles() {
        self.statusPanel = StatusIndicatorView()
        self.view.addSubview(statusPanel)
        self.statusPanel.apply (
            .statusPanelLayoutStyle(at: view)
        )
    }
}
