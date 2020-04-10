//
//  Utilities.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 4/1/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit
import SafariServices

let UTIL = Utilities.shared

class Utilities {
    
    static let shared = Utilities()
    
    func openSafari(in vc: UIViewController, with urlString: String) {
        guard let url = URL(string: urlString) else {
            vc.presentAlert(title: localizedText("invalid_url"), message: localizedText("invalid_url_message"))
            return
        }
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .primary
        vc.present(safariVC, animated: true)
    }
}
