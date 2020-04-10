//
//  AlertController.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

class AlertController: UIViewController {
    
    let viewContainer = UIView()
    let lblTitle = TitleLabel(.center, 20)
    let lblBody = BodyLabel(.center)
    let btnAction = Button(.systemPink)
    
    var alertTitle: String?
    var message: String?
    var btnTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String?, message: String?, btnTitle: String?) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.btnTitle = btnTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .transparent
        
        configureViewContainer()
        configureLblTitle()
        configureBtnAction()
        configureLblBody()
    }
    
    @objc func dismissAlert() {
        dismiss(animated: true)
    }
    
    func configureViewContainer() {
        view.addSubview(viewContainer)
        viewContainer.backgroundColor = .systemBackground
        viewContainer.layer.cornerRadius = 15
        viewContainer.layer.borderWidth = 2
        viewContainer.layer.borderColor = UIColor.white.cgColor
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        viewContainer.centerAnchors(toView: view)
        viewContainer.widthAnchorEqual(constant: 280)
        viewContainer.heightAnchorEqual(constant: 220)
        
        viewContainer.addSubviews(lblTitle, btnAction, lblBody)
    }
    
    func configureLblTitle() {
        lblTitle.text = alertTitle ?? localizedText("error_title")
        
        lblTitle.topAnchorEqual(toView: viewContainer, constant: padding)
        lblTitle.leadingAnchorEqual(toView: viewContainer, constant: padding)
        lblTitle.trailingAnchorEqual(toView: viewContainer, constant: padding)
        lblTitle.heightAnchorEqual(constant: 30)
    }
    
    func configureBtnAction() {
        btnAction.setTitle(btnTitle ?? localizedText("ok"), for: .normal)
        btnAction.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
        btnAction.bottomAnchorEqual(toView: viewContainer, constant: padding)
        btnAction.leadingAnchorEqual(toView: viewContainer, constant: padding)
        btnAction.trailingAnchorEqual(toView: viewContainer, constant: padding)
        btnAction.heightAnchorEqual(constant: 45)
    }
    
    func configureLblBody() {
        lblBody.text = message ?? localizedText("error_message")
        lblBody.numberOfLines = 4
        
        lblBody.topToBottomAnchorEqual(toView: lblTitle, constant: 10)
        lblBody.leadingAnchorEqual(toView: viewContainer, constant: padding)
        lblBody.trailingAnchorEqual(toView: viewContainer, constant: padding)
        lblBody.bottomToTopAnchorEqual(toView: btnAction, constant: padding)
    }
}
