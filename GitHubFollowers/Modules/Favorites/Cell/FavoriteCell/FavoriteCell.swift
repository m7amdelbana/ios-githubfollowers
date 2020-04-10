//
//  FavoriteCell.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 4/2/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let id = "FavoriteCell"
    let imgAvatar = AvatarImageView(frame: .zero)
    let lblUsername = TitleLabel(.left, 22)

    let padding: CGFloat = 15
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(_ favorite: Follower) {
        lblUsername.text = favorite.login
        imgAvatar.load(from: favorite.avatarUrl)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configure() {
        addSubviews(imgAvatar, lblUsername)
        configureImgAvatar()
        configureLblUsername()
        accessoryType = .disclosureIndicator
    }
    
    private func configureImgAvatar() {
        imgAvatar.topAnchorEqual(toView: contentView, constant: padding)
        imgAvatar.bottomAnchorEqual(toView: contentView, constant: padding)
        imgAvatar.leadingAnchorEqual(toView: contentView, constant: padding)
        imgAvatar.squareAnchorEqual(constant: 60)
    }
    
    private func configureLblUsername() {
        lblUsername.centerYAnchorEqual(toView: contentView)
        lblUsername.leadingToTrailingAnchorEqual(toView: imgAvatar, constant: padding * 2)
        lblUsername.trailingAnchorEqual(toView: contentView, constant: padding)
        lblUsername.heightAnchorEqual(constant: 30)
    }
}
