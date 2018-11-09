//
//  OnboardingPresenter.swift
//  Gleam
//
//  Created by albert on 09/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import UIKit

class OnboardingPresenter {
    
    weak var view: OnboardingViewControllerInput?
    private let onboardingModels = [
        OnboardingModel(onboardingImage: #imageLiteral(resourceName: "icOnboarding1"), onboardingTitle: "SKIN CANCER", onboardingDescription: "Skin cancer is in third place in terms of the incidence of oncology detection in Russian men and second in women.", onboardingButtonState: .next),
        OnboardingModel(onboardingImage: #imageLiteral(resourceName: "icOnboarding2"), onboardingTitle: "SKIN SCREENING", onboardingDescription: "The algorithm based on machine learning technology allows you to get a preliminary diagnosis before going to the doctor.", onboardingButtonState: .next),
        OnboardingModel(onboardingImage: #imageLiteral(resourceName: "icOnboarding3"), onboardingTitle: "MEDICAL CARE", onboardingDescription: "If the disease is detected, the application will help you quickly find a specialized clinic and make an appointment.", onboardingButtonState: .start)
    ]
    
    private var page = 0
}

extension OnboardingPresenter: OnboardingViewControllerOutput {
    
    func onboardingViewControllerGetRows(_ view: OnboardingViewController) -> Int {
        return onboardingModels.count
    }
    
    func onboardingViewControllerCell(_ view: OnboardingViewController, collectionView: UICollectionView, indexPath: IndexPath) -> OnboardingCollectionViewCell {
        guard let onboardingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as? OnboardingCollectionViewCell else {
            fatalError("Error converting cell")
        }
        let model = onboardingModels[indexPath.row]
        onboardingCell.setup(with: model)
        return onboardingCell
    }
    
    func onboardingViewControllerTapNext(_ view: OnboardingViewController, collectionView: UICollectionView) {
        guard let currentCell = getCurrentCell(collectionView) else { return }
        let cellSize = view.view.frame.size
        let contentOffset = collectionView.contentOffset
        
        if currentCell.buttonState == .start {
            view.openMainScreen()
        } else {
            let visibleRect = CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height)
            collectionView.scrollRectToVisible(visibleRect, animated: true)
            page += 1
            view.scrollToPage(page: page, buttonTitle: currentCell.buttonTtitle)
        }
    }
    
    func onboardingViewControllerEndDecelerating(_ view: OnboardingViewController, collectionView: UICollectionView) {
        guard let cell = collectionView.visibleCells.first as? OnboardingCollectionViewCell,
            let indexPath = collectionView.indexPath(for: cell),
            let currentCell = getCurrentCell(collectionView) else { return }
        page = indexPath.row
        view.scrollToPage(page: page, buttonTitle: currentCell.buttonTtitle)
    }
    
    func onboardingViewControllerEndScrollingAnimation(_ view: OnboardingViewController, collectionView: UICollectionView) {
        guard let currentCell = getCurrentCell(collectionView) else { return }
        view.scrollToPage(page: page, buttonTitle: currentCell.buttonTtitle)
    }
    
    private func getCurrentCell(_ collectionView: UICollectionView) -> OnboardingCollectionViewCell? {
        return collectionView.visibleCells.last as? OnboardingCollectionViewCell
    }
}
