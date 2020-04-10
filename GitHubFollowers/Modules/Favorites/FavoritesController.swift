//
//  FavoritesController.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

class FavoritesController: BaseController {
    
    let tableView = UITableView()
    var favorites: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favorites = FAV.retriveFavorites()
        setupData()
    }
    
    func setupView() {
        navigationItem.title = localizedText("favorites")
    }
    
    func setupData() {
        tableView.isHidden = favorites.isEmpty
        if favorites.isEmpty {
            presentEmptyState()
        } else {
            dismissEmptyState()
            tableView.reloadData()
        }
    }
    
    func presentEmptyState() {
        let message = localizedText("no_favorites_message")
        DispatchQueue.main.async { self.showEmptyState(with: message, in: self.view) }
    }
    
    func dismissEmptyState() {
        hideEmptyState()
    }
    
    func presentFollowers(with username: String) {
        let vc = FollowersController()
        vc.username = username
        navigationController?.pushViewController(vc, animated: true)
    }
}
