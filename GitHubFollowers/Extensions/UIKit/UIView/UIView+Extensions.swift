//
//  UIView+Extensions.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 4/2/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
