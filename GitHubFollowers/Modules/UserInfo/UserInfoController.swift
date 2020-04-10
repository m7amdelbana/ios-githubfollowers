//
//  UserInfoController.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

protocol UserInfoDelegate: class {
    func didRequestFollowers(for username: String)
}

class UserInfoController: BaseController {
    
    let scrollView = UIScrollView()
    let viewContainer = UIView()
    let viewHeader = UIView()
    let viewItemOne = UIView()
    let viewItemTwo = UIView()
    let lblDate = BodyLabel(.center)
    var viewItems: [UIView] = []
    
    let padding: CGFloat = 20
    
    var user: User!
    var username: String!
    weak var delegate: UserInfoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getUser(username)
    }
    
    private func setupView() {
        let btnDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = btnDone
        
        configureScrollView()
        configureViewContainer()
        setupUI()
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    private func getUser(_ username: String) {
        showLoading(in: view)
        USERS.get(for: username) { [weak self] response in
            guard let self = self else { return }
            self.hideLoading()
            switch response {
            case let .onSuccess(user):
                DispatchQueue.main.async {
                    self.user = user
                    self.congigureElements(with: user)
                }
                break
            case let .onFailure(error):
                self.presentAlert(message: error.message)
                break
            case .onCompleted:
                break
            }
        }
    }
    
    func congigureElements(with user: User) {
        self.add(childVC: UserInfoHeaderController(user: user), to: self.viewHeader)
        self.add(childVC: RepoItemController(user: user, delegate: self), to: self.viewItemOne)
        self.add(childVC: FollowerItemController(user: user, delegate: self), to: self.viewItemTwo)
        self.lblDate.text = "\(localizedText("github_since")) \(user.createdAt.convert(to: .monthYear))"
    }
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.fillAnchors(toView: view)
        scrollView.showsVerticalScrollIndicator = false
    }
    
    func configureViewContainer() {
        scrollView.addSubview(viewContainer)
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.fillAnchors(toView: scrollView)
        
        viewContainer.widthAnchorEqual(toView: scrollView)
        viewContainer.heightAnchorEqual(toView: scrollView)
    }
    
    func setupUI() {
        viewItems = [viewHeader, viewItemOne, viewItemTwo, lblDate]
        for viewItem in viewItems {
            viewContainer.addSubview(viewItem)
            viewItem.translatesAutoresizingMaskIntoConstraints = false
            viewItem.horizontalAnchors(toView: viewContainer, constant: padding)
        }
        
        viewHeader.topAnchorSafeEqual(toView: viewContainer, constant: padding)
        viewHeader.heightAnchorEqual(constant: 200)
        
        viewItemOne.topToBottomAnchorEqual(toView: viewHeader, constant: padding)
        viewItemOne.heightAnchorEqual(constant: 155)
        
        viewItemTwo.topToBottomAnchorEqual(toView: viewItemOne, constant: padding)
        viewItemTwo.heightAnchorEqual(constant: 155)
        
        lblDate.topToBottomAnchorEqual(toView: viewItemTwo, constant: padding)
        lblDate.heightAnchorEqual(constant: 20)
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}

extension UserInfoController: RepoItemDelegate, FollowerItemDelegate {
    
    func didClickedGetHubProfile() {
        UTIL.openSafari(in: self, with: user.htmlUrl)
    }
    
    func didClickedGetFollowers() {
        if user.followers == 0 {
            presentAlert(title: localizedText("no_followers"), message: localizedText("empty_followers_message"))
        } else {
            delegate?.didRequestFollowers(for: user.login)
            dismissViewController()
        }
    }
}
