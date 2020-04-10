//
//  FollowersController.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

class FollowersController: BaseController {
    
    enum CollectionSection {
        case main
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<CollectionSection, Follower>!
    var snapshot: NSDiffableDataSourceSnapshot<CollectionSection, Follower>!
    
    var searchController = UISearchController()
    
    var username: String!
    
    var paginate = Paginate()
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getFollowers(username: username, paginate: paginate)
    }
    
    func setupView() {
        navigationItem.title = username
        
        let btnAdd = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didClickedAdd))
        navigationItem.rightBarButtonItem = btnAdd
        
        configureSearch()
        configureCollectionView()
        configurDataSource()
    }
    
    @objc func didClickedAdd() {
        showLoading(in: view)
        USERS.get(for: username) {  [weak self] response in
            guard let self = self else { return }
            self.hideLoading()
            switch response {
            case let .onSuccess(user):
                self.updateFavorites(with: user)
                break
            case let .onFailure(error):
                self.presentAlert(message: error.message)
                break
            case .onCompleted:
                break
            }
        }
    }
    
    func updateFavorites(with user: User) {
        let error = FAV.updateFavorites(with: user.toFollower(), action: .store)
        if error != nil && error == PersistenceError.exist {
            self.presentAlert(title: localizedText("this_user_exist"), message: localizedText("already_favorited"))
        } else {
            self.presentAlert(title: localizedText("success"), message: localizedText("user_added_to_favorites"))
        }
    }
    
    func getFollowers(username: String, paginate: Paginate) {
        showLoading(in: view)
        self.paginate.isLoading = true
        USERS.followers(for: username, perPage: paginate.perPage, page: paginate.page) { [weak self] response in
            guard let self = self else { return }
            self.hideLoading()
            self.paginate.isLoading = false
            switch response {
            case let .onSuccess(followers):
                self.updateUI(with: followers)
                break
            case let .onFailure(error):
                self.presentAlert(message: error.message)
                break
            case .onCompleted:
                break
            }
        }
    }
    
    func updateUI(with followers: [Follower]) {
        self.paginate.isMoreData = (followers.count == self.paginate.perPage)
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
            self.presentEmptyState()
        } else {
            self.dismissEmptyState()
            self.updateData(on: self.followers)
        }
    }
    
    func presentEmptyState() {
        let message = localizedText("empty_followers_message")
        DispatchQueue.main.async { self.showEmptyState(with: message, in: self.view) }
    }
    
    func dismissEmptyState() {
        hideEmptyState()
    }
    
    func presentFollower(with username: String) {
        let vc = UserInfoController()
        vc.username = username
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.tintColor = .primary
        present(nav, animated: true)
    }
}

extension FollowersController: UserInfoDelegate {
    
    func didRequestFollowers(for username: String) {
        resetUser(for: username)
        getFollowers(username: username, paginate: paginate)
    }
    
    func resetUser(for username: String) {
        self.username = username
        navigationItem.title = username
        paginate = Paginate()
        followers.removeAll()
        filteredFollowers.removeAll()
        let point = CGPoint(x: 0.0, y: view.top - view.safeAreaInsets.top)
        collectionView.setContentOffset(point, animated: true)
    }
}
