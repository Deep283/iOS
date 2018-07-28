//
//  MenuBar.swift
//  Youtube
//
//  Created by vinay shinde on 16/03/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var homeController: HomeController?
    
    lazy var collectionView: UICollectionView = {
       let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = UIColor.red
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    let images = ["home","trending","subscriptions","account"]
    let cellId = "cellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collectionView)
        addContraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addContraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        setUpWhiteHorizontalBar()
        
    }
    
    var whiteBarHorizontalConstraint = NSLayoutConstraint()
    
    func setUpWhiteHorizontalBar()  {
        
        let whiteBarView = UIView()
        whiteBarView.backgroundColor  = UIColor(white: 0.95, alpha: 1)
        whiteBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(whiteBarView)
        
        whiteBarHorizontalConstraint = whiteBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        whiteBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4)
            .isActive = true
        whiteBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        whiteBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        whiteBarHorizontalConstraint.isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuBarCell
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        cell.backgroundColor = UIColor.red
        cell.imageView.image = UIImage(named: images[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.imageView.tintColor = UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
