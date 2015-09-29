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

            let navigationBarAppearace = UINavigationBar.appearance()
            navigationBarAppearace.tintColor = Constants.Colors.textColor
            navigationBarAppearace.barTintColor = .whiteColor()
            navigationBarAppearace.translucent = false
            navigationBarAppearace.titleTextAttributes = [
                NSFontAttributeName : UIFont.systemFontOfSize(22),
                NSForegroundColorAttributeName : Constants.Colors.textColor
            ]

            self.window?.tintColor = Constants.Colors.textColor

            if let tabBarController = self.window?.rootViewController as? UITabBarController {
                tabBarController.tabBar.tintColor = Constants.Colors.textColor
                tabBarController.tabBar.barTintColor = .whiteColor()
                tabBarController.tabBar.translucent = false

                let tabBarAppearance = UITabBar.appearance()
                tabBarAppearance.shadowImage = UIImage()
                tabBarAppearance.backgroundImage = UIImage()

                if let controllersArray = tabBarController.viewControllers as?
                    Array<UINavigationController> {
                    controllersArray[0].tabBarItem.image = .fontAwesomeIconWithName(
                        .User, size: CGSizeMake(30.0, 30.0), textColor: .blackColor())
                    controllersArray[1].tabBarItem.image = .fontAwesomeIconWithName(
                        .Trophy, size: CGSizeMake(30.0, 30.0), textColor: .blackColor())
                    controllersArray[2].tabBarItem.image = .fontAwesomeIconWithName(
                        .InfoCircle, size: CGSizeMake(30.0, 30.0), textColor: .blackColor())
                }

            }
            return true
    }

    // ---------------------------------------------------------------------------------------------
    func applicationDidEnterBackground(application: UIApplication) {
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
