//
//  VidoCell.swift
//  Youtube
//
//  Created by vinay shinde on 03/03/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    func setUpViews()
    {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class VideoCell: BaseCell {
    
    var video: Video?{
        didSet{
            
            setUpThumbnailImage()
            setUpProfileImage()
            guard let title = video?.title else { return }
            titleLabel.text = title
            guard let cName = video?.channel?.name else {return}
            guard let numViews = video?.number_of_views else { return }
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            subtitleTextView.text = "\(cName) ● \((numberFormatter.string(for: numViews))!) views ● 3 years ago"
            let temp = Double((titleLabel.text?.count)!) * 6.65
            let temp2:Double = Double(frame.width -  16 - 44 - 8 - 16)
            if temp > temp2{
                titleLabelContraint?.constant = 44
            }else{
                titleLabelContraint?.constant = 20
            }
        }
    }
    
    func setUpProfileImage()  {
        guard let profileImageUrl = video?.channel?.profile_image_name else { return }
        profileImageView.loadImageUsingUrl(imageUrl: profileImageUrl)
    }
    func setUpThumbnailImage() {
        guard let thumbnailImageUrl = video?.thumbnail_image_name else { return }
        thumbnailImageView.loadImageUsingUrl(imageUrl: thumbnailImageUrl)
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let profileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    let separatorView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 3
        return label
    }()
    let subtitleTextView: UITextView = {
       let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.lightGray
        view.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        return view
    }()
    
    var titleLabelContraint: NSLayoutConstraint?
    
    override func setUpViews()
    {
        super.setUpViews()
        addSubview(thumbnailImageView)
        addSubview(profileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        addSubview(separatorView)
        addContraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addContraintsWithFormat(format: "H:|-16-[v0(44)]", views: profileImageView)
        addContraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, profileImageView, separatorView)
        addContraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 44)
        titleLabel.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor).isActive = true
        
        subtitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        subtitleTextView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        subtitleTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        subtitleTextView.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor).isActive = true
    }
}

