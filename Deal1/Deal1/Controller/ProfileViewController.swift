//
//  ProfileViewController.swift
//  Deal1
//
//  Created by vinay shinde on 01/01/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import UIKit
import STKit

class ProfileViewController: STBaseViewController {

    var userInfo : UserInfo?
    
     @objc func handleLogout() {
        let _ = KeychainWrapper.standard.removeAllKeys()
        KeychainWrapper.standard.set(false, forKey: "isLoggedIn")
        self.navigationController?.popToRootViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.hidesBackButton = true
        navigationItem.title = "Welcome \((userInfo?.name)!)"
    }
}
