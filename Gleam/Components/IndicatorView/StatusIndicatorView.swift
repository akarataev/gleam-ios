//
//  StatusIndicatorView.swift
//  Gleam
//
//  Created by Каратаев Алексей on 09.11.2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class StatusIndicatorView: UIView {
    
    private var statusIndicator: NVActivityIndicatorView!
    private var diagnosisView: DiagnosisIndicatorView!
    private var descriptionLabel: UILabel!
    
    var delegate: StatusIndicatorViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


// MARK: - implement end-points for manage indicator work

extension StatusIndicatorView {
    
    func indicate() {
        self.clearIndicator()
        self.prepareForIndicating()
        self.statusIndicator.startAnimating()
    }
    
    func display(for state: DiagnosisRiskState) {
        DispatchQueue.main.async {
            self.clearIndicator()
            self.prepareForShowDiagnosis(state)
            self.addTapGestureRecognizer()
        }
    }
    
    func clearIndicator() {
        self.statusIndicator?.removeFromSuperview()
        self.diagnosisView?.removeFromSuperview()
    }
}


// MARK: - setup status indicator

private extension StatusIndicatorView {
    
    func prepareForIndicating() {
        self.setupDescriptionLabel()
        self.setupActivityIndicatorView()
    }
    
    func setupDescriptionLabel() {
        self.descriptionLabel = UILabel()
        self.addSubview(descriptionLabel)
        self.descriptionLabel.apply (
            .descriptionLabelStyle,
            .descriptionLabelLayoutStyle(at: self)
        )
    }
    
    func setupActivityIndicatorView() {
        self.statusIndicator = NVActivityIndicatorView (
            frame: .zero, type: .ballBeat, color: .mediumIndicatorColor)
        self.addSubview(statusIndicator)
        self.statusIndicator.apply (
            .statusIndicatorLayoutStyle(view: self, label: descriptionLabel))
        self.statusIndicator.startAnimating()
    }
    
    func addTapGestureRecognizer() {
        let recognizer = UITapGestureRecognizer (
            target: self, action: #selector(diagnosisViewDidTap(sender:)))
        self.diagnosisView.addGestureRecognizer(recognizer)
    }
}


// MARK: - implement tap gesture recognizer handler

extension StatusIndicatorView {
    
    @objc func diagnosisViewDidTap(sender: UIView) {
        self.delegate?.statusIndicatorViewDidTap(sender: sender)
    }
}


// MARK: - implement display diagnosis

private extension StatusIndicatorView {
    
    func prepareForShowDiagnosis(_ state: DiagnosisRiskState) {
        
        self.diagnosisView = DiagnosisIndicatorView()
        self.addSubview(diagnosisView)
        
        self.diagnosisView.apply (
            .diagnosisIndicatorLayoutStyle(at: self, width: state.width)
        )
        
        self.diagnosisView.applyStyles (
            diagnosis: state.description,
            color: state.color
        )
    }
}
