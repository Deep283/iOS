//
//  ViewController.swift
//  Deal1
//
//  Created by vinay shinde on 25/12/17.
//  Copyright © 2017 vinay shinde. All rights reserved.
//

import UIKit
import STKit
class ViewController: STBaseViewController {

    var profileViewController = ProfileViewController()
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if KeychainWrapper.standard.bool(forKey: "isLoggedIn")! {
            self.profileViewController.userInfo = appDelegate.appInfo?.userInfo
            self.navigationController?.pushViewController(self.profileViewController, animated: false)
        }
        else{
            let userLoginController = UserLoginController()
            self.navigationController?.pushViewController(userLoginController, animated: false)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

