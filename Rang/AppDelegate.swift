//
//  AppDelegate.swift
//  Rang
//
//  Created by Martin Kautz on 19.05.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import UIKit
import HockeySDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // ---------------------------------------------------------------------------------------------
    func application(
        application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

            BITHockeyManager.sharedHockeyManager().configureWithIdentifier("39213a77b0b123c2dc63279898d6becf")
            BITHockeyManager.sharedHockeyManager().startManager()
            BITHockeyManager.sharedHockeyManager().authenticator.authenticateInstallation() // This line is obsolete in the crash only build

            UIApplication.sharedApplication().statusBarStyle = .LightContent
            let navigationBarAppearace = UINavigationBar.appearance()
            navigationBarAppearace.tintColor = .whiteColor()
            navigationBarAppearace.barTintColor = Constants.Colors.darkBlue
            navigationBarAppearace.translucent = false
            navigationBarAppearace.titleTextAttributes = [
                NSFontAttributeName : UIFont(name: "HelveticaNeue-Light", size: 22)!,
                NSForegroundColorAttributeName:UIColor.whiteColor()
            ]
            
            self.window?.tintColor = Constants.Colors.darkBlue

            let tabBarController: UITabBarController = self.window?.rootViewController as! UITabBarController
            tabBarController.tabBar.tintColor = .whiteColor()
            tabBarController.tabBar.barTintColor = Constants.Colors.darkBlue
            tabBarController.tabBar.translucent = false

            let tabBarAppearance = UITabBar.appearance()
            tabBarAppearance.shadowImage = UIImage()
            tabBarAppearance.backgroundImage = UIImage()

            let array = tabBarController.viewControllers as! Array<UINavigationController>
            array[0].tabBarItem.image = UIImage.fontAwesomeIconWithName(.User, size: CGSizeMake(30.0, 30.0), textColor: .blackColor())
            array[1].tabBarItem.image = UIImage.fontAwesomeIconWithName(.Trophy, size: CGSizeMake(30.0, 30.0), textColor: .blackColor())
            array[2].tabBarItem.image = UIImage.fontAwesomeIconWithName(.InfoCircle, size: CGSizeMake(30.0, 30.0), textColor: .blackColor())

            return true
    }

    // ---------------------------------------------------------------------------------------------
    func applicationDidEnterBackground(application: UIApplication) {
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}