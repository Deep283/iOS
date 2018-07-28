//
//  MenuBarCell.swift
//  Youtube
//
//  Created by vinay shinde on 18/03/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import UIKit

class MenuBarCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = true
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        return iv
    }()
   
    override var isSelected: Bool
    {
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        
        addSubview(imageView)
        addContraintsWithFormat(format: "H:[v0(28)]", views: imageView)
        addContraintsWithFormat(format: "V:[v0(28)]", views: imageView)
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
