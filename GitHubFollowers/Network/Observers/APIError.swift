//
//  APIError.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

struct AppError {
    
    var code: Int? = 0
    var message: String?
    var type: ErrorType
}

enum ErrorType {

    case server
    case noData
    case parsing
    case network
    case known
}

