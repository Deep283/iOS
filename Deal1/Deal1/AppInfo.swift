//
//  AppInfo.swift
//  Deal1
//
//  Created by vinay shinde on 06/01/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import UIKit

class AppInfo
{
    static let appInfo: AppInfo = AppInfo()
    var userInfo : UserInfo?
    
    private init() {
        
    }
    func getSetUserInfo() -> UserInfo? {
        
        var user = UserInfo()
        let bool = KeychainWrapper.standard.bool(forKey: "isLoggedIn")
        if bool == nil
        {
            KeychainWrapper.standard.set(false, forKey: "isLoggedIn")
            return nil
        }
            user.name = KeychainWrapper.standard.string(forKey: "name")
            user.mail = KeychainWrapper.standard.string(forKey: "email")
            user.mob = KeychainWrapper.standard.string(forKey: "mob")
            user.password = KeychainWrapper.standard.string(forKey: "password")
            return user
    }
}
