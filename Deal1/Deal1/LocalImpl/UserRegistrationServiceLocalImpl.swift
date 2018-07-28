//
//  UserRegistrationServiceLocalImpl.swift
//  Deal1
//
//  Created by vinay shinde on 26/12/17.
//  Copyright © 2017 vinay shinde. All rights reserved.
//

import UIKit

class UserRegistrationServiceLocalImpl: UserRegisterService {
   
    
    func registerUser(userInfo: UserInfo, block: @escaping (UserInfo?,_ error: NSError?) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0)
        {
            block(userInfo,nil)
        }
        
    }
}
