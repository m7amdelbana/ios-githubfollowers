//
//  RootRouter.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

class RootRouter {
    
    static func presentRootScreen(in window: UIWindow, vc: UIViewController) {
        window.makeKeyAndVisible()
        window.rootViewController = vc
    }
}
