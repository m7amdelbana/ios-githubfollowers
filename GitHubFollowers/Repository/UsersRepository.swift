//
//  UsersRepository.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

let USERS = UsersRepository.shared
    
class UsersRepository: Repo {
    
    static let shared = UsersRepository()
    
    func get(for username: String, _ completion: @escaping (Response<User>) -> ()) {
        provider.request(type: User.self, service: Api.Users.get(username), completion: completion)
    }
    
    func followers(for username: String, perPage: Int, page: Int, _ completion: @escaping (Response<[Follower]>) -> ()) {
        provider.request(type: [Follower].self, service: Api.Users.followers(username, perPage, page), completion: completion)
    }
}

