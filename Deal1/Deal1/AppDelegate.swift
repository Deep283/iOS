//
//  AppDelegate.swift
//  Deal1
//
//  Created by vinay shinde on 25/12/17.
//  Copyright © 2017 vinay shinde. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var appInfo: AppInfo?

    func getAppInfo(){
        if self.appInfo == nil {
            self.appInfo = AppInfo.appInfo
            self.appInfo?.userInfo = self.appInfo?.getSetUserInfo()
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        getAppInfo()
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        
        return true
    }
   
    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}

