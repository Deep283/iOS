//
//  ContactCell.swift
//  Contacts
//
//  Created by vinay shinde on 02/02/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    var link: ViewController?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.darkGray
        let starButton = UIButton(type: .system)
        starButton.setImage(#imageLiteral(resourceName: "fav_star-1"), for: .normal)
        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        starButton.tintColor = .cyan
        starButton.addTarget(self, action: #selector(starTapped), for: .touchUpInside)
        accessoryView = starButton
    }
    
    @objc func starTapped(sender: UIButton)
    {
        link?.addToFavourite(cell: self)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
