//
//  UserRegisterService.swift
//  Deal
//
//  Created by vinay shinde on 23/12/17.
//  Copyright © 2017 vinay shinde. All rights reserved.
//

import UIKit
import STKit
protocol UserRegisterService: BaseService
{
    func registerUser(userInfo: UserInfo,block: @escaping (_ responseUserInfo: UserInfo?,_ error: NSError?) -> Void)
}
