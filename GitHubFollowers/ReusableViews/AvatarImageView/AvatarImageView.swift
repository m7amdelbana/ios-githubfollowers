//
//  AvatarImageView.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

class AvatarImageView: UIImageView {
    
    let imgPlaceholder = Images.avatarPlaceholder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = imgPlaceholder
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func load(from url: String) {
        loadImage(url: url)
    }
}
