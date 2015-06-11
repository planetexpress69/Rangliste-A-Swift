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

        self.theTextView.backgroundColor = UIColor.clearColor();
        self.theTextView.delegate = self;


        theTextView.tintColor = Constants.Colors.darkBlue
        self.ackButton.tintColor = Constants.Colors.darkBlue

        var  fontSize: CGFloat = 15.0

        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            fontSize = 20.0
        }
        theTextView.font = UIFont(name: "HelveticaNeue-Light", size: fontSize)

        var sPathToAboutText = NSBundle.mainBundle().pathForResource("about", ofType: "txt")
        var readError: NSError?

        var theAboutText = NSString(contentsOfFile: sPathToAboutText!, encoding: NSUTF8StringEncoding, error: &readError)

        self.theTextView.text = String(theAboutText!)
        self.edgesForExtendedLayout = .None;

        ackButton.setTitle("Danksagung", forState: .Normal)
        ackButton.setBackgroundImage(UIImage.imageWithColor(Constants.Colors.darkBlue), forState: .Normal)
        ackButton.setBackgroundImage(UIImage.imageWithColor(UIColor.blackColor()), forState: .Highlighted)
        ackButton.setBackgroundImage(UIImage.imageWithColor(UIColor.lightGrayColor()), forState: .Disabled)
        ackButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        ackButton.layer.cornerRadius = ackButton.frame.size.height / 2
        ackButton.layer.borderWidth = 0
        ackButton.clipsToBounds = true

        // load version
        var version = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
        var build = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleVersion") as! String

        self.versionLabel.text = "\(version) (\(build))"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        return false
    }


    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        return true
    }


    @IBAction func callFleetmon(sender: AnyObject) -> () {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.fleetmon.com")!)
    }


    @IBAction func callJakota(sender: AnyObject) -> () {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.jakota.de")!)
    }


    @IBAction func callRS(sender: AnyObject) -> () {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.rostocksailing.de")!)
    }

}
