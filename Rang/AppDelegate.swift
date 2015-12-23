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
            navigationBarAppearace.tintColor = .whiteColor()
            navigationBarAppearace.barTintColor = Constants.Colors.textColor
            navigationBarAppearace.translucent = false
            navigationBarAppearace.titleTextAttributes = [
                NSFontAttributeName : UIFont.systemFontOfSize(22),
                NSForegroundColorAttributeName : UIColor.whiteColor()
            ]

            self.window?.tintColor = Constants.Colors.textColor
            self.window?.backgroundColor = UIColor.blueColor()

            if let tabBarController = self.window?.rootViewController as? UITabBarController {
                tabBarController.tabBar.tintColor = .whiteColor()
                tabBarController.tabBar.barTintColor = Constants.Colors.textColor
                tabBarController.tabBar.translucent = false
                tabBarController.view.backgroundColor = .orangeColor();

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
