//
//  ClinicListHeaderView.swift
//  Gleam
//
//  Created by albert on 09/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import UIKit


protocol ClinicListHeaderViewDelegate: class {
    func searchBarDoneButtonTapped(_ clinicListHeaderView: ClinicListHeaderView)
    func searchBarTextDidChanged(_ clinicListHeaderView: ClinicListHeaderView, text: String)
}

class ClinicListHeaderView: UIView {
    
    private lazy var headerTitleLabel = self.createTitleLabel()
    private lazy var searchBar = self.createSearchBar()
    
    weak var delegate: ClinicListHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: 375, height: 124)))
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        headerTitleLabel.text = "Medical care"
        _ = searchBar
        backgroundColor = UIColor.Gleam.neonBlue
    }
}


private extension ClinicListHeaderView {
    
    func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(23)
            make.leading.equalToSuperview().offset(16)
        }
        return label
    }
    
    func createSearchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.backgroundColor = .clear
        searchBar.isTranslucent = true
        searchBar.backgroundImage = UIImage()
        searchBar.setImage(#imageLiteral(resourceName: "icSearch"), for: .search, state: .normal)
        searchBar.setImage(#imageLiteral(resourceName: "icCancel"), for: .clear, state: .normal)
        searchBar.setTextColor(color: .white)
        searchBar.returnKeyType = .done
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.subviews.forEach {
            $0.subviews.filter { $0.isKind(of: UITextField.self) }
                .map { $0 as? UITextField }
                .compactMap { $0 }
                .forEach {
                    $0.backgroundColor = UIColor.Gleam.blueGrey.withAlphaComponent(0.12)
                    $0.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
                }
        }
        
        addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(headerTitleLabel.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-15)
            make.height.equalTo(36)
        }
        
        
        return searchBar
    }
}

extension ClinicListHeaderView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.searchBarDoneButtonTapped(self)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchBarTextDidChanged(self, text: searchText)
    }
}
