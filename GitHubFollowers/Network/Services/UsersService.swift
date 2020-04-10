//
//  UsersService.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import Foundation

extension Api {
    
    enum Users: ServiceProtocol {
        
        case get(_ username: String)
        case followers(_ username: String, _ perPage: Int, _ page: Int)
        
        var path: String {
            switch self {
            case let .get(username):
                return "\(API.SERVICE_USERS)\(username)"
            case let .followers(username, _, _):
                return "\(API.SERVICE_USERS)\(username)/followers"
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .get, .followers:
                return .GET
            }
        }
        
        var parameters: [String : Any]? {
            switch self {
            case .get:
                return nil
            case let .followers(_, perPage, page):
                return [
                    "per_page": perPage,
                    "page": page
                ]
            }
        }
        
        var headers: Headers? {
            switch self {
            case .get, .followers:
                return nil
            }
        }
        
        var body: Any? {
            switch self {
            case .get, .followers:
                return nil
            }
        }
    }
}


