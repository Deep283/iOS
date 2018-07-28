//
//  UserLoginController.swift
//  Deal1
//
//  Created by vinay shinde on 25/12/17.
//  Copyright © 2017 vinay shinde. All rights reserved.
//

import UIKit
import STKit

class UserLoginController: STBaseViewController {
    
    var inputContainerView : UIView = {
       let uiview = UIView()
        uiview.translatesAutoresizingMaskIntoConstraints = false
        uiview.layer.cornerRadius = 10
        uiview.backgroundColor = UIColor.white
        return uiview
    }()
    
    var username: UITextField = {
         var tf = UITextField()
         tf.placeholder = "username"
         tf.translatesAutoresizingMaskIntoConstraints = false
         return tf
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var password: UITextField = {
        var tf = UITextField()
        tf.placeholder = "password"
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    lazy var stLogin: STButton = {
        var button = STButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.blue, for: .normal)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 10
        return button
    }()
    lazy var register: STButton = {
        var button = STButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    var label: UILabel = {
        var label = UILabel()
        label.text = "Not a registered user,Register here!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        return label
    }()
    var service = UserLoginServiceLocalImpl()
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
        super.viewDidLoad()
        self.view.addSubview(stLogin)
        self.view.addSubview(label)
        self.view.addSubview(register)
        self.view.addSubview(inputContainerView)
        setUpUIView()
        setUpOtherComponents()
        stLogin.action = {
           let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.frame = self.view.bounds
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            activityIndicator.superview?.alpha = 0.5
            self.service.loginUser(name: self.username.text!, password: self.password.text!, block: { (_ responseUserInfo: UserInfo?, _ error: NSError?) in
                
                if ((error == nil))
                {
                    KeychainWrapper.standard.set((responseUserInfo?.name!)!,forKey: "name")
                    KeychainWrapper.standard.set((responseUserInfo?.mail!)!, forKey: "email")
                    KeychainWrapper.standard.set((responseUserInfo?.mob!)!, forKey: "mobile")
                    KeychainWrapper.standard.set((responseUserInfo?.password!)!, forKey: "password")
                    KeychainWrapper.standard.set(true, forKey: "isLoggedIn")
                    let viewController = self.navigationController?.viewControllers[0] as! ViewController
                    viewController.profileViewController.userInfo = responseUserInfo
                    activityIndicator.superview?.alpha = 1.0
                    activityIndicator.removeFromSuperview()
                    self.navigationController?.pushViewController(viewController.profileViewController, animated: true)
                }
                else
                {
                    let alert = UIAlertController(title: "Error", message: "Login Failed", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
        register.action = {
            let userRegisterationController = UserRegistrationController()
            self.navigationController?.pushViewController(userRegisterationController, animated: true)
        }
    }

    func setUpOtherComponents()
    {
        //LoginButton
        stLogin.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor,constant: 12).isActive = true
        stLogin.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        stLogin.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        stLogin.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //Label
        label.topAnchor.constraint(equalTo: stLogin.bottomAnchor, constant: 20).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //RegisterButton
        register.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        register.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12).isActive = true
        register.widthAnchor.constraint(equalTo: label.widthAnchor).isActive = true
        register.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setUpUIView() {
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -24).isActive = true
        inputContainerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        inputContainerView.addSubview(username)
        inputContainerView.addSubview(separatorView)
        inputContainerView.addSubview(password)
        
        //username
        username.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        username.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        username.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        username.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/2).isActive = true
        
        //separatorView
        separatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        separatorView.topAnchor.constraint(equalTo: username.bottomAnchor).isActive = true
        separatorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //password
        password.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        password.topAnchor.constraint(equalTo: separatorView.bottomAnchor).isActive = true
        password.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        password.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/2).isActive = true
        
    }
}
