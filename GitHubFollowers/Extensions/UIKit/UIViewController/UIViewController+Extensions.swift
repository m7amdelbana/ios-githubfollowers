//
//  UIViewController+Extensions.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String? = nil, message: String? = nil, btnTitle: String? = nil) {
        DispatchQueue.main.async {
            let vc = AlertController(title: title, message: message, btnTitle: btnTitle)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
        }
    }
}
