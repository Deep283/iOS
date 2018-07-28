//
//  ExpandableNames.swift
//  Contacts
//
//  Created by vinay shinde on 30/01/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import Foundation

struct ExpandableNames {
    
    var isExpanded: Bool
    var contacts: [Contact]
    
}
struct Contact {
    var name: String
    var isFavourited: Bool
}
