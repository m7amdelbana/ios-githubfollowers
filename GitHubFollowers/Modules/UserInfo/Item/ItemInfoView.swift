//
//  ItemInfoView.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 4/1/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class ItemInfoView: UIView {
    
    let imgIcon = UIImageView()
    let lblTitle = TitleLabel(.left, 15)
    let lblCount = TitleLabel(.center, 15)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(type: ItemInfoType, count: Int) {
        lblCount.text = String(count)
        switch type {
        case .repos:
            imgIcon.image = Symbols.repos
            lblTitle.text = localizedText("public_repos")
            break
        case .gists:
            imgIcon.image = Symbols.gists
            lblTitle.text = localizedText("public_gists")
            break
        case .followers:
            imgIcon.image = Symbols.followers
            lblTitle.text = localizedText("followers")
            break
        case .following:
            imgIcon.image = Symbols.following
            lblTitle.text = localizedText("following")
            break
        }
    }
    
    private func configure() {
        addSubviews(imgIcon, lblTitle, lblCount)
        
        imgIcon.translatesAutoresizingMaskIntoConstraints = false
        imgIcon.contentMode = .scaleAspectFill
        imgIcon.tintColor = .label
        
        imgIcon.topAnchorEqual(toView: self)
        imgIcon.leadingAnchorEqual(toView: self)
        imgIcon.squareAnchorEqual(constant: 20)
        
        lblTitle.centerYAnchorEqual(toView: imgIcon)
        lblTitle.leadingToTrailingAnchorEqual(toView: imgIcon, constant: 15)
        lblTitle.trailingAnchorEqual(toView: self)
        lblTitle.heightAnchorEqual(constant: 20)
        
        lblCount.topToBottomAnchorEqual(toView: lblTitle, constant: 5)
        lblCount.horizontalAnchors(toView: self)
        lblCount.heightAnchorEqual(constant: 20)
    }
}

