//
//  Paginate.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 4/1/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import Foundation

struct Paginate {
    
    var perPage: Int = 30
    var page: Int = 1
    var isMoreData: Bool = true
    var isLoading: Bool = false
}
