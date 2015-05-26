//
//  AppDelegate.swift
//  Rang
//
//  Created by Martin Kautz on 19.05.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // ---------------------------------------------------------------------------------------------
    func application(
        application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

            UIApplication.sharedApplication().statusBarStyle = .LightContent
            var navigationBarAppearace = UINavigationBar.appearance()
            navigationBarAppearace.tintColor = UIColor.whiteColor()
            navigationBarAppearace.barTintColor = Constants.Colors.darkBlue
            navigationBarAppearace.translucent = false
            navigationBarAppearace.titleTextAttributes = [
                NSFontAttributeName : UIFont(name: "HelveticaNeue-Light", size: 22)!,
                NSForegroundColorAttributeName:UIColor.whiteColor()
            ]
            
            self.window?.tintColor = Constants.Colors.darkBlue
            return true
    }

    // ---------------------------------------------------------------------------------------------
    func applicationDidEnterBackground(application: UIApplication) {
        NSUserDefaults.standardUserDefaults().synchronize()
    }

}

