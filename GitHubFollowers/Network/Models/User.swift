//
//  User.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import Foundation

struct User: Codable, Hashable {
    
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
    }
    
    func toFollower() -> Follower {
        Follower(login: login, avatarUrl: avatarUrl)
    }
}
