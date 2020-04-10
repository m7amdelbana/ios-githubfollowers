//
//  EmptyStateView.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {
    
    private let lblMessage = TitleLabel(.center, 22)
    private let imgLogo = UIImageView()
    private var superView = UIView()
    
    private let padding: CGFloat = 40
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String, view: UIView) {
        super.init(frame: view.bounds)
        superView = view
        lblMessage.text = message
        configure()
    }
    
    func show() {
        superView.addSubview(self)
    }
    
    func hide() {
        removeFromSuperview()
    }
    
    private func configure() {
        configureLblMessage()
        configureImgLogo()
    }
    
    private func configureLblMessage() {
        addSubview(lblMessage)
        lblMessage.numberOfLines = 4
        lblMessage.textColor = .secondaryLabel
        
        lblMessage.centerYAnchorEqual(toView: self, constant: -150)
        lblMessage.leadingAnchorEqual(toView: self, constant: padding)
        lblMessage.trailingAnchorEqual(toView: self, constant: padding)
    }
    
    private func configureImgLogo() {
        addSubview(imgLogo)
        imgLogo.image = Images.emptyStateLogo
        imgLogo.translatesAutoresizingMaskIntoConstraints = false
        
        imgLogo.widthAnchorScaled(toView: self, multiplier: 1.2)
        imgLogo.widthAnchorScaledToHeight(toView: self, multiplier: 1.0)
        imgLogo.trailingAnchorEqual(toView: self, constant: -200)
        imgLogo.bottomAnchorEqual(toView: self, constant: -60)
    }
}
