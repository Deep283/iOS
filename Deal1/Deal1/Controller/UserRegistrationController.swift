//
//  UserRegistrationController.swift
//  Deal1
//
//  Created by vinay shinde on 25/12/17.
//  Copyright © 2017 vinay shinde. All rights reserved.
//

import UIKit
import STKit

class UserRegistrationController: STBaseViewController{
    
    var inputContainerView : UIView = {
        let uiview = UIView()
        uiview.translatesAutoresizingMaskIntoConstraints = false
        uiview.layer.cornerRadius = 5
        uiview.backgroundColor = UIColor.white
        return uiview
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let separatorView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let separatorView3: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var name: UITextField = {
        var tf = UITextField()
        tf.placeholder = "name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    var email: UITextField = {
        var tf = UITextField()
        tf.placeholder = "email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    var phone: UITextField = {
        var tf = UITextField()
        tf.placeholder = "mobile number"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    var password: UITextField = {
        var tf = UITextField()
        tf.placeholder = "password"
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    var userInfo = UserInfo()
    lazy var stRegister: STButton = {
        var button = STButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    var service = UserRegistrationServiceLocalImpl()
    
    func setUpRegiterButton()
    {
        stRegister.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor,constant: 12).isActive = true
        stRegister.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        stRegister.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        stRegister.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    func setUpUIView() {
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputContainerView.heightAnchor.constraint(equalToConstant: 204).isActive = true
        
        inputContainerView.addSubview(name)
        inputContainerView.addSubview(separatorView)
        inputContainerView.addSubview(email)
        inputContainerView.addSubview(separatorView2)
        inputContainerView.addSubview(phone)
        inputContainerView.addSubview(separatorView3)
        inputContainerView.addSubview(password)
        
        //username
        name.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        name.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        name.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        name.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/4).isActive = true
        
        //separatorView
        separatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        separatorView.topAnchor.constraint(equalTo: name.bottomAnchor).isActive = true
        separatorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //password
        email.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        email.topAnchor.constraint(equalTo: separatorView.bottomAnchor).isActive = true
        email.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        email.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/4).isActive = true
        
        //separatorView
        separatorView2.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        separatorView2.topAnchor.constraint(equalTo: email.bottomAnchor).isActive = true
        separatorView2.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        separatorView2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        //phone
        phone.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        phone.topAnchor.constraint(equalTo: separatorView2.bottomAnchor).isActive = true
        phone.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        phone.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/4).isActive = true
        //separatorView
        separatorView3.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        separatorView3.topAnchor.constraint(equalTo: phone.bottomAnchor).isActive = true
        separatorView3.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        separatorView3.heightAnchor.constraint(equalToConstant: 1).isActive = true
        //password
        password.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        password.topAnchor.constraint(equalTo: separatorView3.bottomAnchor).isActive = true
        password.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        password.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/4).isActive = true
    }
    
    private func validate(phoneNumber: String) -> Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = phoneNumber.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  phoneNumber == filtered
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
     override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(inputContainerView)
        self.view.addSubview(stRegister)
        setUpUIView()
        setUpRegiterButton()
        stRegister.action = {
            
            guard self.name.text! != "",self.password.text! != "",
                self.email.text! != "",self.phone.text! != ""
                else {
                    let alert = UIAlertController(title: "Error", message: "Please fill all the fields", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
            }
            
            guard self.isValidEmail(testStr: self.email.text!) else {
                let alert = UIAlertController(title: "Error", message: "Enter valid email address", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            guard self.validate(phoneNumber: self.phone.text!) else {
                let alert = UIAlertController(title: "Error", message: "Enter valid phone number", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            self.userInfo.name = self.name.text!
            self.userInfo.password = self.password.text!
            self.userInfo.mail = self.self.email.text!
            self.userInfo.mob = self.phone.text!
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            activityIndicator.hidesWhenStopped = true
            activityIndicator.frame = self.view.bounds
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            activityIndicator.superview?.alpha = 0.5
            self.service.registerUser(userInfo: self.userInfo, block:  { (_ responseUserInfo: UserInfo?, _ error: NSError?) in
                if ((error == nil))
                {
                    KeychainWrapper.standard.set(self.userInfo.name!,forKey: "name")
                    KeychainWrapper.standard.set(self.userInfo.mail!, forKey: "email")
                    KeychainWrapper.standard.set(self.userInfo.mob!, forKey: "mob")
                    KeychainWrapper.standard.set(self.userInfo.password!, forKey: "password")
                    KeychainWrapper.standard.set(true, forKey: "isLoggedIn")
                    let viewController = self.navigationController?.viewControllers[0] as! ViewController
                    viewController.profileViewController.userInfo = responseUserInfo
                    activityIndicator.stopAnimating()
                    activityIndicator.superview?.alpha = 1.0
                    activityIndicator.removeFromSuperview()
                    self.email.text = ""
                    self.name.text = ""
                    self.password.text = ""
                    self.phone.text = ""
                    self.navigationController?.popToRootViewController(animated: true)
                }
                else
                {
                    let alert = UIAlertController(title: "Error", message: "Registeration Failed", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
}

