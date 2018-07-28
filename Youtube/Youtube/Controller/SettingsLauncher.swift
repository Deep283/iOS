//
//  SettingsLauncher.swift
//  Youtube
//
//  Created by vinay shinde on 28/05/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import UIKit

class Setting: NSObject {
    var name: settingName
    var imageName: String
    
    init(name: settingName, imageName: String)
    {
        self.name = name
        self.imageName = imageName
    }
}

enum settingName: String {
    case cancel = "Cancel and Dismissed"
    case settings = "Settings"
    case termsAndPolicy = "Terms and Privacy Policy"
    case feedback = "Feedback"
    case help = "Help"
    case switchAccount = "Switch Account"
    
}

class SettingsLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var homeController: HomeController?
    
    var settings: [Setting] = { 
        var stg = [Setting]()
        stg.append(Setting(name: .settings, imageName: "settings"))
        stg.append(Setting(name: .termsAndPolicy , imageName: "privacy"))
        stg.append(Setting(name: .feedback, imageName: "feedback"))
        stg.append(Setting(name: .help, imageName: "help"))
        stg.append(Setting(name: .switchAccount, imageName: "switch_account"))
        stg.append(Setting(name: .cancel, imageName: "cancel"))
        return stg
    }()
    
     let blackView = UIView()
    let collectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    @objc func showSettings()
    {
        if let window = UIApplication.shared.keyWindow{
            self.blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(collectionView)
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 300)
            blackView.frame = window.frame
            blackView.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height - 300, width: window.frame.width, height: 300)
            }, completion: nil)
        }
    }
    @objc func handleDismiss()
    {
        handleDismissed(setting: nil)
    }
    func handleDismissed(setting: Setting?)
    {
        if let window = UIApplication.shared.keyWindow{
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.blackView.alpha = 0
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 300)
            }, completion: { (completed: Bool) in
                if setting != nil && setting?.name != .cancel{
                    self.homeController?.showControllerForSetting(setting: setting!)
                }
                
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let setting = self.settings[indexPath.item]
        handleDismissed(setting: setting)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! SettingCell
        cell.setting = settings[indexPath.item]
        return cell
    }
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: "cellId")
        
    }
}
