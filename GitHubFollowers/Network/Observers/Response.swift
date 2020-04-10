//
//  Response.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

enum Response<T> {

    case onSuccess(T)
    case onFailure(AppError)
    case onCompleted
}
