//
//  UserLoginService.swift
//  Deal
//
//  Created by vinay shinde on 23/12/17.
//  Copyright © 2017 vinay shinde. All rights reserved.
//

import UIKit
import STKit

protocol UserLoginService: BaseService {

    func loginUser(name: String,password: String,block: @escaping (_ responseUserInfo: UserInfo?,_ error: NSError?) -> Void)
}
