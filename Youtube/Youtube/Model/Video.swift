//
//  Video.swift
//  Youtube
//
//  Created by vinay shinde on 20/05/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import UIKit

struct Video: Decodable
{
    var title: String?
    var number_of_views: Int?
    var thumbnail_image_name: String?
    var channel: Channel?
    var duration: Int?
}
struct Channel: Decodable
{
    var name: String?
    var profile_image_name: String?
}
