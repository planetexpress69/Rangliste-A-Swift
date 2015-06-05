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
            // Configure the SDK in here only!
            BITHockeyManager.sharedHockeyManager().startManager()
            BITHockeyManager.sharedHockeyManager().authenticator.authenticateInstallation() // This line is obsolete in the crash only build

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

            var tabBarController: UITabBarController = self.window?.rootViewController as! UITabBarController
            var array = tabBarController.viewControllers as! Array<UINavigationController>
            array[0].tabBarItem.image = UIImage.fontAwesomeIconWithName(.User, size: CGSizeMake(30.0, 30.0), textColor: UIColor.blackColor())
            array[1].tabBarItem.image = UIImage.fontAwesomeIconWithName(.Trophy, size: CGSizeMake(30.0, 30.0), textColor: UIColor.blackColor())
            array[2].tabBarItem.image = UIImage.fontAwesomeIconWithName(.InfoCircle, size: CGSizeMake(30.0, 30.0), textColor: UIColor.blackColor())

            return true
    }

    // ---------------------------------------------------------------------------------------------
    func applicationDidEnterBackground(application: UIApplication) {
        NSUserDefaults.standardUserDefaults().synchronize()
    }

}

/*
@{
@"title"     : self.regattaNameTextField.text,
@"pos"       : self.regattaPosTextField.text,
@"field"     : self.regattaFieldTextField.text,
@"races"     : self.regattaRacesTextField.text,
@"threeDays" : [NSNumber numberWithBool:threeDays],
@"type"      : self.dSelectedRegatta,
@"score"     : [NSNumber numberWithFloat:score]
};
*/

/*
(
{
field = 103;
pos = 21;
races = 3;
score = "96.69904";
threeDays = 0;
title = "Rahnsdorfer Opti-Pokal";
type =         {
factor = 1;
id = 1;
title = Ranglistenregatta;
};
},
{
field = 28;
pos = 6;
races = 6;
score = "85.42857";
threeDays = 0;
title = "Boddenpokal HGW";
type =         {
factor = 1;
id = 1;
title = Ranglistenregatta;
};
},
{
field = 54;
pos = 13;
races = 5;
score = "85.38271";
threeDays = 0;
title = "Fritze-Bollmann-Regatta";
type =         {
factor = 1;
id = 1;
title = Ranglistenregatta;
};
},
{
field = 434;
pos = 127;
races = 5;
score = "85.16129";
threeDays = 1;
title = "Easter Regatta Portoroz";
type =         {
factor = 1;
id = 1;
title = Ranglistenregatta;
};
},
{
field = 102;
pos = 36;
races = 4;
score = "78.82353";
threeDays = 0;
title = "Herbstpokal/BJ\U00fcM";
type =         {
factor = 1;
id = 1;
title = Ranglistenregatta;
};
},
{
field = 74;
pos = 26;
races = 2;
score = "75.63363";
threeDays = 0;
title = "LJ\U00fcM MV";
type =         {
factor = 1;
id = 1;
title = Ranglistenregatta;
};
},
{
field = 54;
pos = 25;
races = 5;
score = "60.98765";
threeDays = 0;
title = Bernsteinpokal;
type =         {
factor = 1;
id = 1;
title = Ranglistenregatta;
};
}
)
*/

