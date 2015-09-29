//
//  AboutViewController.swift
//  Rangliste-A-Swift
//
//  Created by Martin Kautz on 11.06.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UITextViewDelegate {

    // ---------------------------------------------------------------------------------------------
    @IBOutlet weak var theTextView: UITextView!
    @IBOutlet weak var ackButton: UIButton!
    @IBOutlet weak var versionLabel: UILabel!
    // ---------------------------------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Über Rangliste"

        self.theTextView.backgroundColor = .clearColor()
        self.theTextView.delegate = self

        theTextView.tintColor = Constants.Colors.textColor
        //self.ackButton.tintColor = .whit

        var  fontSize: CGFloat = 15.0

        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            fontSize = 20.0
        }
        theTextView.font = .systemFontOfSize(fontSize)
        theTextView.textColor = Constants.Colors.textColor
        theTextView.tintColor = .redColor()

        let sPathToAboutText = NSBundle.mainBundle().pathForResource("about", ofType: "txt")

        var theAboutText: NSString?
        do {
            theAboutText = try NSString(contentsOfFile: sPathToAboutText!, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
            theAboutText = nil
        }

        self.theTextView.text = String(theAboutText!)
        self.edgesForExtendedLayout = .None

        ackButton.setTitle("Danksagung", forState: .Normal)
        ackButton.setBackgroundImage(.imageWithColor(Constants.Colors.textColor), forState: .Normal)
        ackButton.setBackgroundImage(.imageWithColor(Constants.Colors.textColor), forState: .Highlighted)
        ackButton.setBackgroundImage(.imageWithColor(.lightGrayColor()), forState: .Disabled)
        ackButton.layer.cornerRadius = ackButton.frame.size.height / 2
        ackButton.layer.borderWidth = 0
        ackButton.clipsToBounds = true

        // load version
        let version = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
        let build = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleVersion") as! String

        self.versionLabel.text = "\(version) (\(build))"

        self.navigationController?.navigationBar.barTintColor = .whiteColor()

        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.hideBottomHairline()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // ---------------------------------------------------------------------------------------------
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        return false
    }

    // ---------------------------------------------------------------------------------------------
    func textView(
        textView: UITextView,
        shouldInteractWithURL URL: NSURL,
        inRange characterRange: NSRange) -> Bool {
        return true
    }

    // ---------------------------------------------------------------------------------------------
    @IBAction func callFleetmon(sender: AnyObject) -> () {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.fleetmon.com")!)
    }

    // ---------------------------------------------------------------------------------------------
    @IBAction func callJakota(sender: AnyObject) -> () {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.jakota.de")!)
    }

    // ---------------------------------------------------------------------------------------------
    @IBAction func callRS(sender: AnyObject) -> () {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.rostocksailing.de")!)
    }

    // ---------------------------------------------------------------------------------------------
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
}
