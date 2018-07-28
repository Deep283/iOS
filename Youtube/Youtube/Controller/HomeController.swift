//
//  ViewController.swift
//  Youtube
//
//  Created by vinay shinde on 03/03/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let cellId = "cellId"
    let trendingId = "trendingId"
    let subscriptionsId = "subscriptionsId"
    let titles = ["Home", "Trending", "Subscriptions", "Account"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = true
        setUpCollectionView()
        setUpNavigationBar()
        setUpMenuBar()
        setUpBarButtons()
    }
    
    func setUpCollectionView()  {
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingId)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionsId)
        collectionView?.isPagingEnabled = true
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
    }
    
//    func swipeAction(swipeGesture: UISwipeGestureRecognizer)
//    {
//        if swipeGesture.direction == .up {
//            navigationController?.setNavigationBarHidden(true, animated: true)
//        }
//        else{
//            navigationController?.setNavigationBarHidden(false, animated: true)
//        }
//    }
    
    func setUpNavigationBar()  {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.red
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
    }
 
    func setUpBarButtons()  {
        
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let menuImage = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal)
        let searchBarButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        let menuBarButton = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(handleMenu))
        navigationItem.rightBarButtonItems = [menuBarButton, searchBarButton]
    }
    @objc func handleSearch()
    {
        print("Searchbutton")
    }
    lazy var settingsLauncher: SettingsLauncher = {
       let launcher = SettingsLauncher()
       launcher.homeController = self
       return launcher
    }()
    
    @objc func handleMenu()
    {
       settingsLauncher.showSettings()
    }
    
    func showControllerForSetting(setting: Setting) {
        let dummyControllerForSetting = UIViewController()
        dummyControllerForSetting.navigationItem.title = setting.name.rawValue
        dummyControllerForSetting.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummyControllerForSetting, animated: true)
    }
    
    func scrollToMenuIndex(menuIndex: Int)  {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        setTitleForIndex(index: menuIndex)
    }
    
    private func setTitleForIndex(index: Int){
        if let titleLabel = navigationItem.titleView as? UILabel{
            titleLabel.text = "  \(titles[index])"
        }
        
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    private func setUpMenuBar() {
        
        let redView = UIView()
        redView.backgroundColor = UIColor.red

        view.addSubview(redView)
        view.addSubview(menuBar)
        view.addContraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addContraintsWithFormat(format: "V:[v0(50)]", views: redView)
        view.addContraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addContraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.whiteBarHorizontalConstraint.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        setTitleForIndex(index: Int(index))
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var identifier: String = cellId
        
        if indexPath.item == 1{
            identifier = trendingId
        }
        else if indexPath.item == 2{
            identifier = subscriptionsId
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FeedCell
        cell.homeController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height - 50)
    }
}
