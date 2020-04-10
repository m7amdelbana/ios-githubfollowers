//
//  BaseController.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

class BaseController: UIViewController {
    
    var loading: LoadingController?
    var emptyState: EmptyStateView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    func dismissKeyboardTapGesture(view: UIView) {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
}

// MARK: - Loading

extension BaseController {
    
    func showLoading(in view: UIView) {
        DispatchQueue.main.async {
            self.loading = LoadingController(in: view)
            self.loading?.show()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.loading?.hide()
        }
    }
}

// MARK: - Empty State

extension BaseController {
    
    func showEmptyState(with message: String, in view: UIView) {
        DispatchQueue.main.async {
            self.emptyState = EmptyStateView(message: message, view: view)
            self.emptyState?.show()
        }
    }
    
    func hideEmptyState() {
        DispatchQueue.main.async {
            self.emptyState?.hide()
        }
    }
}
