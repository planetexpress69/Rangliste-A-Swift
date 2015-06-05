//
//  RegattaDetailViewController.swift
//  Rang
//
//  Created by Martin Kautz on 19.05.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import UIKit

class RegattaDetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var regattaNameTextField: UITextField!
    @IBOutlet weak var regattaPosTextField: UITextField!
    @IBOutlet weak var regattaFieldTextField: UITextField!
    @IBOutlet weak var regattaRacesTextField: UITextField!
    @IBOutlet weak var selectorButton: UIButton!
    @IBOutlet weak var threeDaysButton: UIButton!

    var regattaList: [[String : AnyObject]]?
    var dSelectedRegatta: [String : AnyObject]?
    var theRegatta: [String : AnyObject]?
    var currentIndex: Int = -1

    //MARK: - View lifecycle
    // ---------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Detail"

        regattaNameTextField.delegate = self
        regattaNameTextField.keyboardType = .ASCIICapable
        regattaNameTextField.autocapitalizationType = .None
        regattaNameTextField.autocorrectionType = .No
        regattaNameTextField.returnKeyType = .Done

        regattaPosTextField.delegate = self
        regattaPosTextField.keyboardType = .NumberPad
        regattaPosTextField.autocapitalizationType = .None
        regattaPosTextField.autocorrectionType = .No
        regattaPosTextField.returnKeyType = .Next

        regattaFieldTextField.delegate = self
        regattaFieldTextField.keyboardType = .NumberPad
        regattaFieldTextField.autocapitalizationType = .None
        regattaFieldTextField.autocorrectionType = .No
        regattaFieldTextField.returnKeyType = .Next

        regattaRacesTextField.delegate = self
        regattaRacesTextField.keyboardType = .NumberPad
        regattaRacesTextField.autocapitalizationType = .None
        regattaRacesTextField.autocorrectionType = .No
        regattaRacesTextField.returnKeyType = .Next

        selectorButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        selectorButton.setBackgroundImage(UIImage.imageWithColor(Constants.Colors.darkBlue),
            forState: UIControlState.Normal)
        selectorButton.setBackgroundImage(UIImage.imageWithColor(.blackColor()),
            forState: UIControlState.Highlighted)
        selectorButton.setBackgroundImage(UIImage.imageWithColor(.clearColor()),
            forState: UIControlState.Disabled)
        selectorButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        selectorButton.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        selectorButton.setTitleColor(Constants.Colors.darkBlue, forState: .Disabled)
        selectorButton.layer.cornerRadius = selectorButton.frame.size.height / 2
        selectorButton.layer.borderWidth = 0
        selectorButton.clipsToBounds = true

        selectorButton.addTarget(self, action: "requestSelector:", forControlEvents: .TouchUpInside)

        var editButton = UIBarButtonItem(title: String.fontAwesomeIconWithName(.Edit),
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "toggleEdit:")
        var attrs = [
            NSFontAttributeName : UIFont.fontAwesomeOfSize(20),
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        editButton.setTitleTextAttributes(attrs, forState: .Normal)
        navigationItem.rightBarButtonItem = editButton

        threeDaysButton.titleLabel?.font = UIFont.fontAwesomeOfSize(20)
        threeDaysButton.setTitle(String.fontAwesomeIconWithName(.CheckSquareO),
            forState: UIControlState.Normal)
        threeDaysButton.setTitleColor(Constants.Colors.darkBlue,
            forState: UIControlState.Normal)
        threeDaysButton.addTarget(self, action: "toggleThreeDays:",
            forControlEvents: .TouchUpInside)
    }

    // ---------------------------------------------------------------------------------------------
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        if currentIndex == -1 {
            setEditing(true, animated: true)
        }
        else {
            var name: String = ""
            if let obj: AnyObject = theRegatta?["name"] {
                name = obj as! String
            }
            regattaNameTextField.text = name

            title = name

            var position: Int = 0
            if let obj: AnyObject = theRegatta!["position"] {
                position = obj as! Int
            }
            regattaPosTextField.text = String(position)

            var numberOfTimedBoats: Int = 0
            if let obj: AnyObject = theRegatta!["numberOfTimedBoats"] {
                numberOfTimedBoats = obj as! Int
            }
            regattaFieldTextField.text = String(numberOfTimedBoats)

            var numberOfRaces: Int = 0
            if let obj: AnyObject = theRegatta!["numberOfRaces"] {
                numberOfRaces = obj as! Int
            }
            regattaRacesTextField.text = String(numberOfRaces)

            var threeDays: Bool = false
            if let obj: AnyObject = theRegatta!["threeDays"] {
                threeDays = obj as! Bool
            }

            if threeDays {
                threeDaysButton.setTitle(String.fontAwesomeIconWithName(.CheckSquareO),
                    forState: UIControlState.Normal)
            } else {
                threeDaysButton.setTitle(String.fontAwesomeIconWithName(.SquareO),
                    forState: UIControlState.Normal)
            }

            self.setEditing(false, animated: true)
        }

        initRegattas()

        if (NSUserDefaults.standardUserDefaults().objectForKey("selectedRegatta") != nil) {
            if let s: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("selectedRegatta") {
                dSelectedRegatta = s as? [String : AnyObject]
                selectorButton.setTitle(s["title"] as? String, forState: UIControlState.Normal)
            }
        }
        else {
            // set list[0]
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        

    }

    // ---------------------------------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - User triggered actions
    // ---------------------------------------------------------------------------------------------
    //@IBAction func requestSelector(sender: UIButton) {
    //    println("Boom")
    //}

    // ---------------------------------------------------------------------------------------------
    @IBAction func toggleEdit(sender: UIBarButtonItem) {
        if editing {
            setEditing(false, animated: true)
            store()
        } else {
            setEditing(true, animated: true)
        }
    }

    // ---------------------------------------------------------------------------------------------
    @IBAction func toggleThreeDays(sender: UIButton) {
        var threeDays: Bool = false
        if let obj: AnyObject = theRegatta!["threeDays"] {
            threeDays = obj as! Bool
        }
        if threeDays == false {
            threeDaysButton.setTitle(String.fontAwesomeIconWithName(.CheckSquareO),
                forState: UIControlState.Normal)
        } else {
            threeDaysButton.setTitle(String.fontAwesomeIconWithName(.SquareO),
                forState: UIControlState.Normal)
        }

        theRegatta?["threeDays"] = !threeDays
    }

    // MARK: - Editing
    // ---------------------------------------------------------------------------------------------
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        if editing {
            regattaNameTextField.userInteractionEnabled     = true
            regattaNameTextField.borderStyle                = .RoundedRect

            regattaPosTextField.userInteractionEnabled      = true
            regattaPosTextField.borderStyle                 = .RoundedRect

            regattaFieldTextField.userInteractionEnabled    = true
            regattaFieldTextField.borderStyle               = .RoundedRect

            regattaRacesTextField.userInteractionEnabled    = true
            regattaRacesTextField.borderStyle               = .RoundedRect

            threeDaysButton.userInteractionEnabled          = true
            selectorButton.enabled                          = true

            var editButton = UIBarButtonItem(title: String.fontAwesomeIconWithName(.Check),
                style: UIBarButtonItemStyle.Plain,
                target: self,
                action: "toggleEdit:")
            var attrs = [
                NSFontAttributeName : UIFont.fontAwesomeOfSize(20),
                NSForegroundColorAttributeName: UIColor.whiteColor()
            ]
            editButton.setTitleTextAttributes(attrs, forState: .Normal)
            navigationItem.rightBarButtonItem = editButton
        }
        else {
            regattaNameTextField.userInteractionEnabled    = false
            regattaNameTextField.borderStyle               = .None
            // -------------------------------------------------------------------------------------
            regattaPosTextField.userInteractionEnabled     = false
            regattaPosTextField.borderStyle                = .None
            // -------------------------------------------------------------------------------------
            regattaFieldTextField.userInteractionEnabled   = false
            regattaFieldTextField.borderStyle              = .None
            // -------------------------------------------------------------------------------------
            regattaRacesTextField.userInteractionEnabled   = false
            regattaRacesTextField.borderStyle              = .None
            // -------------------------------------------------------------------------------------
            threeDaysButton.userInteractionEnabled         = false
            // -------------------------------------------------------------------------------------
            dSelectedRegatta                               = nil
            // -------------------------------------------------------------------------------------
            selectorButton.enabled                          = false
            selectorButton.titleLabel!.textColor             = .grayColor()

            var editButton = UIBarButtonItem(title: String.fontAwesomeIconWithName(.Edit),
                style: UIBarButtonItemStyle.Plain,
                target: self,
                action: "toggleEdit:")
            var attrs = [
                NSFontAttributeName : UIFont.fontAwesomeOfSize(20),
                NSForegroundColorAttributeName: UIColor.whiteColor()
            ]
            editButton.setTitleTextAttributes(attrs, forState: .Normal)
            navigationItem.rightBarButtonItem = editButton
        }
    }

    //MARK: - Load & save regatta from/to store
    // ---------------------------------------------------------------------------------------------
    func loadRegattaWithIndex(index: Int) {
        if index != -1 {
            theRegatta = SimpleDataProvider.sharedInstance.dataStorageArray[index]
        }
        currentIndex = index
    }

    // ---------------------------------------------------------------------------------------------
    func store() {
        var name = ""
        if let oname = regattaNameTextField.text {
            name = oname as String
        }

        var position = ""
        if let oposition = regattaPosTextField.text {
            position = oposition as String
        }

        var numberOfTimedBoats = ""
        if let onumberOfTimedBoats = regattaFieldTextField.text {
            numberOfTimedBoats = onumberOfTimedBoats as String
        }

        var numberOfRaces = ""
        if let onumberOfRaces = regattaRacesTextField.text {
            numberOfRaces = onumberOfRaces as String
        }

        var threeDays = false
        if let othreeDays: AnyObject = theRegatta!["threeDays"] {
            threeDays = othreeDays as! Bool
        }

        var r: Dictionary<String, AnyObject> = [
            "name" : name,
            "position" : position.toInt()!,
            "numberOfTimedBoats" : numberOfTimedBoats.toInt()!,
            "numberOfRaces" : numberOfRaces.toInt()!,
            "threeDays" : threeDays
        ]

        if currentIndex == -1 {
            SimpleDataProvider.sharedInstance.addRegatta(r) // add new
        }
        else {
            SimpleDataProvider.sharedInstance.updateRegatta(r, atIndex:currentIndex) // update existing
        }
        navigationController?.popToRootViewControllerAnimated(true) // get outta here
    }

    func initRegattas() {

        if let
            path     = NSBundle.mainBundle().pathForResource("aRegattas", ofType: "json"),
            url = NSURL(fileURLWithPath: path),
            data = NSData(contentsOfURL: url),
            array = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [[String: AnyObject]]

        {
            self.regattaList = array
        }
    }

/*
    func initDatasource() {
        let path = NSBundle.mainBundle().pathForResource("aRegattas", ofType: "json") as! String
        let jsonData = NSData.dataWithContentsOfFile(path, options: .DataReadingMappedIfSafe, error: nil)
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        var persons : NSArray = jsonResult["person"] as NSArray
    }
*/


    /*


    func initDatasource()
    {
    NSError     *readError      = nil;
    NSString    *sPathToJson    = [[NSBundle mainBundle]pathForResource:@"aRegattas" ofType:@"json"];
    NSData      *dJson          = [NSData dataWithContentsOfFile:sPathToJson
    options:NSDataReadingMapped
    error:&readError];
    if (dJson && !readError) {
    NSError *parsingError = nil;
    self.aRegattas = [NSJSONSerialization JSONObjectWithData:dJson
    options:NSJSONReadingAllowFragments
    error:&parsingError];
    if (!self.aRegattas && parsingError) {
    NSLog(@"error: %@", parsingError);
    }


    } else {
    NSLog(@"error: %@", readError);
    }
    }

*/
    @IBAction func requestSelector(sender: UIButton) {

        let alertController = UIAlertController(title: "Regatta typ", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)


        if let array = regattaList {
            for regatta in array {
                let action = UIAlertAction(
                    title: regatta["title"] as! String,
                    style: .Default,
                    handler: {
                        (alert: UIAlertAction!) in self.setSelectedRegattaType(alert.title)
                    }
                )
                alertController.addAction(action)
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) {
            (action) in
            // ...
        }
        alertController.addAction(cancelAction)
/*
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // ...
        }
        alertController.addAction(OKAction) */
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
        
    }

    func setSelectedRegattaType(title: String) {
        if let array = regattaList {
            for regatta in array {
                if let foo = regatta["title"] as? String {
                    if foo == title {
                        println("foo: \(foo) == \(title)")
                        NSUserDefaults.standardUserDefaults().setObject(regatta, forKey: "selectedRegatta")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        selectorButton.setTitle(title, forState: UIControlState.Normal)
                        break
                    }
                }
            }
        }
    }
}
