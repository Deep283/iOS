//
//  FeedCell.swift
//  Youtube
//
//  Created by vinay shinde on 07/06/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
//    lazy var swipeGesture: UISwipeGestureRecognizer = {
//        let sg = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
//        sg.delaysTouchesBegan = true
//        sg.delegate = self
//        return sg
//    } ()
    
    var homeController: HomeController?
    
    lazy var collectionView: UICollectionView = {
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
//    @objc func swipeAction()
//    {
//        homeController?.swipeAction(swipeGesture: swipeGesture)
//    }
    
    func fetchVideos() {
        ApiService.sharedInstance.fetchVideos(urlString: "home.json") { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
    var videos: [Video]?
    
    let cellId = "cellId"
    
    override func setUpViews() {
        super.setUpViews()
        //collectionView.addGestureRecognizer(swipeGesture)
        fetchVideos()
        addSubview(collectionView)
        addContraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addContraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        collectionView.contentInset = UIEdgeInsets(top: 35,left: 0,bottom: 0,right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50,left: 0,bottom: 0,right: 0)
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoLauncher = VideoLauncher()
        videoLauncher.launchVideoPlayer()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.width - 16 - 16 * (collectionView.frame.width / collectionView.frame.height)
        return CGSize(width: collectionView.frame.width, height: height - 92)
    }
    
}
