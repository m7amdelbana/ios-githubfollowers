//
//  Favorites+TableView.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 4/2/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

extension FavoritesController: UITableViewDelegateAndDataSource {
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.initialize(cellClass: FavoriteCell.self, id: FavoriteCell.id, rowHeight: 90, delegate: self, dataSource: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.id) as! FavoriteCell
        cell.setupCell(favorites[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        presentFollowers(with: favorite.login)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        remove(favorite: favorites[indexPath.row], at: indexPath)
    }
    
    func remove(favorite: Follower, at indexPath: IndexPath) {
        let error = FAV.updateFavorites(with: favorite, action: .remove)
        if error != nil {
            presentAlert(title: localizedText("unable_to_remove"), message: localizedText("unable_to_remove_message"))
        } else {
            favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            if favorites.isEmpty {
                tableView.isHidden = true
                presentEmptyState()
            }
        }
    }
}
