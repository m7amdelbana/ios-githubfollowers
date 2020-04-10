//
//  FollowerItemController.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 4/1/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

protocol FollowerItemDelegate: class {
    func didClickedGetFollowers()
}

class FollowerItemController: ItemInfoViewController {
    
    weak var delegate: FollowerItemDelegate?
    
    init(user: User, delegate: FollowerItemDelegate?) {
        super.init(user: user)
        self.user = user
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        viewItemOne.setupView(type: .followers, count: user.followers)
        viewItemTwo.setupView(type: .following, count: user.following)
        btnAction.set(backgroundColor: .primary, title: localizedText("get_followers"))
    }
    
    override func didClieckedBtn() {
        delegate?.didClickedGetFollowers()
    }
}
