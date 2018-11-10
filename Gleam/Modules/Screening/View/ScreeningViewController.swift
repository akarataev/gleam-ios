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
    var captureButton: CaptureButton!
    var modeSegmented: CaptureModeSegment!
    
    var statusPanel: StatusIndicatorView! {
        didSet { statusPanel.delegate = self }
    }

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


// MARK: - implement light style for status bar

extension ScreeningViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


// MARK: - implement hide navigation bar

extension ScreeningViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden (
            true, animated: true
        )
    }
}


// MARK: - implement style applying

extension ScreeningViewController {

    func applyStyles() {
        self.applyScreeningViewStyles()
        self.applyStatusPanelStyles()
        self.applyCaptureButtonStyles()
        self.addCaptureButtonTarget()
        self.applyModeSegmentedStyles()
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
    
    func applyCaptureButtonStyles() {
        self.captureButton = CaptureButton()
        self.view.addSubview(captureButton)
        self.captureButton.apply (
            .captureButtonStyle,
            .captureButtonLayoutStyle(at: statusPanel)
        )
    }
    
    func addCaptureButtonTarget() {
        self.captureButton.addTarget (
            self,
            action: #selector(captureButtonDidTap(_:)),
            for: .touchUpInside
        )
    }
    
    func applyModeSegmentedStyles() {
        self.modeSegmented = CaptureModeSegment()
        self.modeSegmented.parentView = view
        self.view.addSubview(modeSegmented)
        self.modeSegmented.apply (
            .captureSegmentLayoutStyle(at: view)
        )
    }
}


// MARK: - implement capture button handler

extension ScreeningViewController {
    
    @objc func captureButtonDidTap(_ sender: CaptureButton) {        
        self.statusPanel.indicate()
        self.selectCaptureButtonAnimation(for: sender)
        self.output.userRequestImageProcessing(mode: modeSegmented.mode)
    }
    
    func selectCaptureButtonAnimation(for sender: CaptureButton) {
        switch self.modeSegmented.mode {
        case .live:
            captureButton.repeatPulseAnimation(count: 9)
        case .photo:
            captureButton.repeatPulseAnimation(count: 1)
        }
    }
}


// MARK: - implement displaying results of classification

extension ScreeningViewController {
    
    func displayDiagnosis(state: DiagnosisRiskState) {
        self.statusPanel.display(for: state)
    }
}


// MARK: - implement status indicator view delegate

extension ScreeningViewController: StatusIndicatorViewDelegate {
    
    func statusIndicatorViewDidTap(sender: UIView) {
        self.output.routeToClinicScreen()
    }
}
