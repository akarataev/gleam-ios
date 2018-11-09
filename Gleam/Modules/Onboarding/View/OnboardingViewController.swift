//
//  OnboardingViewController.swift
//  Gleam
//
//  Created by albert on 09/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation

import UIKit
import SnapKit

// MARK: - OnboardingViewControllerInput
protocol OnboardingViewControllerInput: class {
    func scrollToPage(page: Int, buttonTitle: String)
    func openMainScreen()
}

// MARK: - OnboardingViewControllerOutput
protocol OnboardingViewControllerOutput: class {
    func onboardingViewControllerGetRows(_ view: OnboardingViewController) -> Int
    func onboardingViewControllerCell(_ view: OnboardingViewController, collectionView: UICollectionView, indexPath: IndexPath) -> OnboardingCollectionViewCell
    func onboardingViewControllerTapNext(_ view: OnboardingViewController, collectionView: UICollectionView)
    func onboardingViewControllerEndDecelerating(_ view: OnboardingViewController, collectionView: UICollectionView)
    func onboardingViewControllerEndScrollingAnimation(_ view: OnboardingViewController, collectionView: UICollectionView)
}

// MARK: - OnboardingViewController
class OnboardingViewController: UIViewController {
    
    var output: OnboardingViewControllerOutput!
    
    private lazy var collectionView = self.createCollectionView()
    private lazy var pageControl = self.createPageControl()
    private lazy var nextButton = self.createNextButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OnboardingConfigurator.configure(self)
        registerCells()
        nextButton.setTitle("Next step", for: .normal)
        _ = pageControl
    }
    
    private func registerCells() {
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: "OnboardingCollectionViewCell")
    }
    
    private func handlePaging() {
        
    }
    
    @objc func nextButtonTapped() {
        output.onboardingViewControllerTapNext(self, collectionView: collectionView)
    }
}

// MARK: - OnboardingViewControllerInput
extension OnboardingViewController: OnboardingViewControllerInput {
    
    func scrollToPage(page: Int, buttonTitle: String) {
        pageControl.currentPage = page
        nextButton.setTitle(buttonTitle, for: .normal)
    }
    
    func openMainScreen() {
        // TODO: - Open main screen
    }
}

private extension OnboardingViewController {
    
    func createCollectionView() -> UICollectionView {
        let collectionView = OnboardingCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-137)
        }
        return collectionView
    }
    
    func createNextButton() -> UIButton {
        let button = UIButton()
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.setTitleColor(UIColor.Gleam.brownishGrey, for: .normal)
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-24)
            make.centerX.equalToSuperview()
        }
        
        return button
    }
    
    func createPageControl() -> UIPageControl {
        let pageControl = OnboardingPageControl()
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.height.equalTo(9)
            make.bottom.equalTo(nextButton.snp.top).offset(-56)
            make.top.equalTo(collectionView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        return pageControl
    }
}

// MARK: - UICollectionViewDataSource
extension OnboardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output.onboardingViewControllerGetRows(self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return output.onboardingViewControllerCell(self, collectionView: collectionView, indexPath: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - UIScrollViewDelegate
extension OnboardingViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        output.onboardingViewControllerEndDecelerating(self, collectionView: collectionView)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        output.onboardingViewControllerEndScrollingAnimation(self, collectionView: collectionView)
    }
}
