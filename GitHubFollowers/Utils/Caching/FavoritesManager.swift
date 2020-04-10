//
//  FavoriteManager.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 4/3/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import Foundation

let FAV = FavoriteManager.shared

class FavoriteManager: PersistenceManager {
    
    static let shared = FavoriteManager()
    
    func retriveFavorites() -> [Follower] {
        return retrive(key: Keys.favorites, type: [Follower].self) ?? []
    }
    
    func storeFavorites(favorites: [Follower]) {
        store(key: Keys.favorites, data: favorites)
    }
    
    func updateFavorites(with favorite: Follower, action: PersistenceAction) -> PersistenceError? {
        var favorites = retriveFavorites()
        switch action {
        case .remove:
            favorites.removeAll { $0.login == favorite.login }
            storeFavorites(favorites: favorites)
            return nil
        case .store:
            if favorites.contains(favorite) {
                return .exist
            } else {
                favorites.append(favorite)
                storeFavorites(favorites: favorites)
                return nil
            }
        }
    }
}
