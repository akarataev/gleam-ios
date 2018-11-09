//
//  ScreeningScreeningModuleConfigurator.swift
//  Gleam
//
//  Created by Каратаев Алексей on 09/11/2018.
//  Copyright © 2018 Apptolab. All rights reserved.
//

import UIKit
import Typhoon
import AVKit

class ScreeningModuleConfigurator: TyphoonAssembly {
    
    @objc public dynamic func configurateVideoCaptureSession() -> Any {
        return TyphoonDefinition.withClass(VideoCaptureSession.self)
    }
    
    @objc public dynamic func configurateAVCaptureVideoPreviewLayer() -> Any {
        return TyphoonDefinition.withClass(AVCaptureVideoPreviewLayer.self) {
            definition in
            definition?.useInitializer(#selector(AVCaptureVideoPreviewLayer.init(session:))) {
                initializer in
                initializer?.injectParameter(
                    with: self.configurateVideoCaptureSession()
                )
            }
        }
    }
    
    @objc public dynamic func configureVideoCapturePreviewLayer() -> Any {
        return TyphoonDefinition.withClass(VideoCapturePreviewLayer.self) {
            definition in
            definition?.injectProperty(
                Selector(("captureSession")),
                with: self.configurateVideoCaptureSession()
            )
            definition?.injectProperty(
                Selector(("previewLayer")),
                with: self.configurateAVCaptureVideoPreviewLayer()
            )
            definition?.perform(
                afterInjections: #selector(
                    VideoCapturePreviewLayer.self.prepareForCaptureVideo
                )
            )
        }
    }

    @objc public dynamic func configureScreeningViewController() -> Any {
        return TyphoonDefinition.withClass(ScreeningViewController.self) {
            definition in
            definition?.injectProperty(
                Selector(("output")),
                with: self.configureScreeningPresenter()
            )
            definition?.injectProperty (
                Selector(("screeningView")),
                with: self.configureVideoCapturePreviewLayer()
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
