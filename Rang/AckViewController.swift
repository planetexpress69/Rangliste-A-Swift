//
//  AckViewController.swift
//  Rangliste-A-Swift
//
//  Created by Martin Kautz on 11.06.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import UIKit

class AckViewController: UIViewController {

    // ---------------------------------------------------------------------------------------------
    @IBOutlet weak var theTextView: UITextView!
    // ---------------------------------------------------------------------------------------------


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        title = "Danksagungen"
        var  fontSize: CGFloat = 8.0

        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            fontSize = 15.0
        }
        theTextView.font = .systemFontOfSize(fontSize)

        let sPathToAboutText = NSBundle.mainBundle().pathForResource("3rdparty", ofType: "txt")

        var theAboutText: NSString?
        do {
            theAboutText = try NSString(contentsOfFile: sPathToAboutText!, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
            theAboutText = nil
        }

        self.theTextView.text = String(theAboutText!)
        self.edgesForExtendedLayout = .None

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

    // ---------------------------------------------------------------------------------------------
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }


}
