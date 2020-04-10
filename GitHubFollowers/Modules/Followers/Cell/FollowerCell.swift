//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let id = "FollowerCell"
    let imgAvatar = AvatarImageView(frame: .zero)
    let lblUsername = TitleLabel(.center, 15)

    let padding: CGFloat = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(_ follower: Follower) {
        lblUsername.text = follower.login
        imgAvatar.load(from: follower.avatarUrl)
    }
    
    private func configure() {
        addSubviews(imgAvatar, lblUsername)
        configureImgAvatar()
        configureLblUsername()
    }
    
    private func configureImgAvatar() {
        imgAvatar.topAnchorEqual(toView: contentView, constant: padding)
        imgAvatar.leadingAnchorEqual(toView: contentView, constant: padding)
        imgAvatar.trailingAnchorEqual(toView: contentView, constant: padding)
        imgAvatar.heightAnchorEqualWidthAnchor(toView: imgAvatar)
    }
    
    private func configureLblUsername() {
        lblUsername.topToBottomAnchorEqual(toView: imgAvatar, constant: 10)
        lblUsername.leadingAnchorEqual(toView: contentView, constant: padding)
        lblUsername.trailingAnchorEqual(toView: contentView, constant: padding)
        lblUsername.heightAnchorEqual(constant: 20)
    }
}

