//
//  ItemInfoViewController.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 4/1/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

class ItemInfoViewController: UIViewController {
    
    let stackView = UIStackView()
    let viewItemOne = ItemInfoView()
    let viewItemTwo = ItemInfoView()
    let btnAction = Button()
    
    let padding: CGFloat = 20
    
    var user: User!

    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewContainer()
        setupUI()
    }
    
    func configureViewContainer() {
        view.layer.cornerRadius = 20
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func setupUI() {
        view.addSubviews(stackView, btnAction)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchorEqual(toView: view, constant: padding)
        stackView.horizontalAnchors(toView: view, constant: padding)
        stackView.heightAnchorEqual(constant: 50)
        
        btnAction.topToBottomAnchorEqual(toView: stackView, constant: padding)
        btnAction.horizontalAnchors(toView: view, constant: padding)
        btnAction.heightAnchorEqual(constant: 50)
        
        btnAction.addTarget(self, action: #selector(didClieckedBtn), for: .touchUpInside)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(viewItemOne)
        stackView.addArrangedSubview(viewItemTwo)
    }
    
    @objc func didClieckedBtn() { }
}
