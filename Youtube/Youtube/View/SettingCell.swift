//
//  SettingCell.swift
//  Youtube
//
//  Created by vinay shinde on 29/05/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var setting: Setting?{
        didSet{
            self.nameLabel.text = setting?.name.rawValue
            self.iconImageView.image = UIImage(named: (setting?.imageName)!)?.withRenderingMode(.alwaysTemplate)
            self.iconImageView.tintColor = UIColor.darkGray
            
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    override func setUpViews() {
        super.setUpViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addContraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        
        addContraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        
        addContraintsWithFormat(format: "V:[v0(30)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    
    }
}
