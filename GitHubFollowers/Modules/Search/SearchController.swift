//
//  SearchController.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

class SearchController: BaseController {
    
    let imgLogo = UIImageView()
    let txtFldUsername = TextField()
    let btnGetFollowers = Button(.primary, localizedText("get_followers"))
    
    var isUsernameEntered: Bool {
        return !(txtFldUsername.text?.isEmpty ?? false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        dismissKeyboardTapGesture(view: view)
    }
    
    private func setupView() {
        view.addSubviews(imgLogo, txtFldUsername, btnGetFollowers)
        configureImgLogo()
        configureTxtFldUsername()
        configureBtnGetFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func getFollowersAction() {
        guard isUsernameEntered else {
            presentAlert(title: localizedText("enter_username"), message: localizedText("enter_username_message"), btnTitle: localizedText("ok"))
            return
        }
        presentFollowers()
    }
    
    func presentFollowers() {
        let username = txtFldUsername.text
        txtFldUsername.resignFirstResponder()
        txtFldUsername.text = ""
        let vc = FollowersController()
        vc.username = username
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        txtFldUsername.text = ""
    }
    
    func configureImgLogo() {
        imgLogo.translatesAutoresizingMaskIntoConstraints = false
        imgLogo.image = Images.ghLogo
        
        let topImg: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        imgLogo.topAnchorEqual(toView: view, constant: topImg)
        imgLogo.centerXAnchorEqual(toView: view)
        imgLogo.squareAnchorEqual(constant: 200)
    }
    
    func configureTxtFldUsername() {
        txtFldUsername.placeholder = localizedText("enter_a_username")
        txtFldUsername.returnKeyType = .go
        txtFldUsername.delegate = self
        
        txtFldUsername.topToBottomAnchorEqual(toView: imgLogo, constant: 40)
        txtFldUsername.horizontalAnchors(toView: view, constant: 50)
        txtFldUsername.heightAnchorEqual(constant: 50)
    }
    
    func configureBtnGetFollowers() {
        btnGetFollowers.addTarget(self, action: #selector(getFollowersAction), for: .touchUpInside)
        
        btnGetFollowers.bottomAnchorSafeEqual(toView: view, constant: 50)
        btnGetFollowers.horizontalAnchors(toView: view, constant: 50)
        btnGetFollowers.heightAnchorEqual(constant: 50)
    }
}

extension SearchController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtFldUsername:
            getFollowersAction()
            break
        default:
            break
        }
        return true
    }
}
