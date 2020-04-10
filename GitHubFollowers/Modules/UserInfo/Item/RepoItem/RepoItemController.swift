//
//  RepoItemController.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 4/1/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

protocol RepoItemDelegate: class {
    func didClickedGetHubProfile()
}

class RepoItemController: ItemInfoViewController {
    
    weak var delegate: RepoItemDelegate?
    
    init(user: User, delegate: RepoItemDelegate?) {
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
        viewItemOne.setupView(type: .repos, count: user.publicRepos)
        viewItemTwo.setupView(type: .gists, count: user.publicGists)
        btnAction.set(backgroundColor: .systemPurple, title: localizedText("gitgub_profile"))
    }
    
    override func didClieckedBtn() {
        delegate?.didClickedGetHubProfile()
    }
}
