//
//  LoadingController.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

class LoadingController: UIViewController {
    
    private var activityIndicator: UIActivityIndicatorView!
    private var superView: UIView!
    
    init(in superView: UIView) {
        super.init(nibName: nil, bundle: nil)
        self.superView = superView
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        view = UIView(frame: superView.bounds)
        superView.addSubview(view)
        view.backgroundColor = .systemBackground
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        view.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchorEqual(toView: view)
        activityIndicator.centerYAnchorEqual(toView: view)
    }
    
    func show() {
        activityIndicator.startAnimating()
        view.alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 0.8
        }
    }
    
    func hide() {
        view.removeFromSuperview()
        view = nil
    }
}
