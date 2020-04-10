//
//  UserInfoHeaderController.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

class UserInfoHeaderController: UIViewController {
    
    let imgAvatar = AvatarImageView(frame: .zero)
    let lblUserName = TitleLabel(.left, 32)
    let lblName = SubTitleLabel(17)
    let imgLocation = UIImageView()
    let lblLocation = SubTitleLabel(17)
    let lblBio = BodyLabel(.left)
    
    var user: User!
    
    let imgPadding: CGFloat = 15
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupUI()
        configure()
    }
    
    func configure() {
        imgAvatar.load(from: user.avatarUrl)
        lblUserName.text = user.login
        lblName.text = user.name ?? ""
        lblLocation.text = user.location ?? localizedText("na")
        lblBio.text = user.bio ?? localizedText("no_bio_message")
        lblBio.numberOfLines = 3
        
        imgLocation.image = Symbols.map
        imgLocation.tintColor = .secondaryLabel
    }
    
    private func setupView() {
        view.addSubviews(imgAvatar, lblUserName, lblName, imgLocation, lblLocation, lblBio)
    }
    
    private func setupUI() {
        imgAvatar.topAnchorEqual(toView: view)
        imgAvatar.leadingAnchorEqual(toView: view)
        imgAvatar.squareAnchorEqual(constant: 100)
        
        lblUserName.topAnchorEqual(toView: imgAvatar)
        lblUserName.leadingToTrailingAnchorEqual(toView: imgAvatar, constant: imgPadding)
        lblUserName.trailingAnchorEqual(toView: view)
        lblUserName.heightAnchorEqual(constant: 40)
        
        lblName.centerYAnchorEqual(toView: imgAvatar, constant: 8)
        lblName.leadingToTrailingAnchorEqual(toView: imgAvatar, constant: imgPadding)
        lblName.trailingAnchorEqual(toView: view)
        lblName.heightAnchorEqual(constant: 20)
        
        imgLocation.translatesAutoresizingMaskIntoConstraints = false
        imgLocation.bottomAnchorEqual(toView: imgAvatar)
        imgLocation.leadingToTrailingAnchorEqual(toView: imgAvatar, constant: imgPadding)
        imgLocation.squareAnchorEqual(constant: 20)
        
        lblLocation.centerYAnchorEqual(toView: imgLocation)
        lblLocation.leadingToTrailingAnchorEqual(toView: imgLocation, constant: 5)
        lblLocation.trailingAnchorEqual(toView: view)
        lblLocation.heightAnchorEqual(constant: 20)
        
        lblBio.topToBottomAnchorEqual(toView: imgAvatar, constant: imgPadding)
        lblBio.leadingAnchorEqual(toView: imgAvatar)
        lblBio.trailingAnchorEqual(toView: view)
        lblBio.heightAnchorEqual(constant: 80)
    }
}
