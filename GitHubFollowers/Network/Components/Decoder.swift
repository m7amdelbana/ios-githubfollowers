//
//  Decoder.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 4/2/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import Foundation

class Decoder: JSONDecoder {
    
    override init() {
        super.init()
        keyDecodingStrategy = .convertFromSnakeCase
        dateDecodingStrategy = .iso8601
    }
}
