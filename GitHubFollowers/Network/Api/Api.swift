//
//  API.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import Foundation

let API = Api(.development)

enum APIConfigurations: String {
    
    case development = "debug"
    case stage = "stage"
    case release = "release"
}

final class Api {
    
    let config: APIConfigurations
    
    var BASE_URL: String {
        switch config {
        case .development:
            return "https://api.github.com/"
        case .stage:
            return "https://api.github.com/"
        case .release:
            return "https://api.github.com/"
        }
    }
    
    init(_ config: APIConfigurations) {
        self.config = config
    }
    
    // MARK:- USERS
    
    let SERVICE_USERS = "users/"
}

