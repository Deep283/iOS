//
//  UserLoginServiceLocalImpl.swift
//  Deal1
//
//  Created by vinay shinde on 26/12/17.
//  Copyright © 2017 vinay shinde. All rights reserved.
//

import UIKit

class UserLoginServiceLocalImpl: UserLoginService {
    
    var defaultRes: UserInfo = {
        var user = UserInfo()
        user.name = "default"
        user.mail = "default"
        user.mob = "00"
        user.password = "default"
        return user
    }()
    func loginUser(name: String, password: String, block: @escaping (_ responseUserInfo: UserInfo?,_ error: NSError?) -> Void) {
        
          DispatchQueue.main.asyncAfter(deadline: .now() + 5.0)
          {
            block(self.defaultRes,nil)
          }
    }
}
