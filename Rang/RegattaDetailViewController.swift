//
//  RegattaDetailViewController.swift
//  Rang
//
//  Created by Martin Kautz on 19.05.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import UIKit

class RegattaDetailViewController: UIViewController, UITextFieldDelegate {

    // ---------------------------------------------------------------------------------------------
    @IBOutlet weak var regattaNameTextField: UITextField!
    @IBOutlet weak var regattaPosTextField: UITextField!
    @IBOutlet weak var regattaFieldTextField: UITextField!
    @IBOutlet weak var regattaRacesTextField: UITextField!
    @IBOutlet weak var selectorButton: UIButton!
    @IBOutlet weak var threeDaysButton: UIButton!
    // ---------------------------------------------------------------------------------------------
    var regattaTypeList: [[String : AnyObject]]?
    var theRegatta: [String : AnyObject]?
    var currentIndex: Int = -1
    var isThreeDays: Bool = false
    // ---------------------------------------------------------------------------------------------

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
        selectorButton.setBackgroundImage(UIImage.imageWithColor(UIColor.blackColor()),
            forState: UIControlState.Highlighted)
        selectorButton.setBackgroundImage(UIImage.imageWithColor(UIColor.clearColor()),
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
            isThreeDays = false
            threeDaysButton.setTitle(String.fontAwesomeIconWithName(.SquareO), forState: .Normal)
        }
        else {
            var name: String = ""
            if let obj: AnyObject = theRegatta?["title"] {
                name = obj as! String
            }
            regattaNameTextField.text = name

            title = name

            var position: Int = 0
            if let obj: AnyObject = theRegatta!["pos"] {
                position = obj as! Int
            }
            regattaPosTextField.text = String(position)

            var numberOfTimedBoats: Int = 0
            if let obj: AnyObject = theRegatta!["field"] {
                numberOfTimedBoats = obj as! Int
            }
            regattaFieldTextField.text = String(numberOfTimedBoats)

            var numberOfRaces: Int = 0
            if let obj: AnyObject = theRegatta!["races"] {
                numberOfRaces = obj as! Int
            }
            regattaRacesTextField.text = String(numberOfRaces)

            var threeDays: Bool = false
            if let obj: AnyObject = theRegatta!["threeDays"] {
                threeDays = obj as! Bool
            }

            isThreeDays = threeDays
            threeDaysButton.setTitle(threeDays ? String.fontAwesomeIconWithName(.CheckSquareO) : String.fontAwesomeIconWithName(.SquareO), forState: .Normal)
            setEditing(false, animated: true)
        }

        initRegattas()

        if let
            selectedRegatta = NSUserDefaults.standardUserDefaults().objectForKey("selectedRegatta") as? Dictionary<String, AnyObject>,
            title = selectedRegatta["title"] as? String {
                selectorButton.setTitle(title, forState: .Normal)
        }
        else {
            if let
                firstRegatta = regattaTypeList![0] as? Dictionary {
                    NSUserDefaults.standardUserDefaults().setObject(firstRegatta, forKey: "selectedRegatta")
                    selectorButton.setTitle(firstRegatta["title"] as? String, forState: .Normal)
            }

        }
    }

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
        isThreeDays = !isThreeDays
        threeDaysButton.setTitle(isThreeDays ?
            String.fontAwesomeIconWithName(.CheckSquareO) :
            String.fontAwesomeIconWithName(.SquareO),
            forState: UIControlState.Normal)
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
            //dSelectedRegatta                               = nil
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

        if let
            theRegatta = theRegatta,
            threeDays = theRegatta["threeDays"] as? Bool {
        }

        if currentIndex != -1 {
            threeDays = isThreeDays
        }

        var f = Float(1.0)
        if let
            selectedRegatta: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("selectedRegatta"),
            dict: Dictionary<String, AnyObject> = selectedRegatta as? Dictionary,
            factor: Float = dict["factor"] as? Float {
                f = factor
        }

        if let
            pos = position.toInt(),
            field = numberOfTimedBoats.toInt(),
            races = numberOfRaces.toInt() {
                var r: Dictionary<String, AnyObject> = [
                    "title" : name,
                    "pos" : pos,
                    "field" : field,
                    "races" : races,
                    "threeDays" : threeDays,
                    "score" : calcForPosition(pos, scoredBoats: field, regattaFactor: f)
                ]
                if currentIndex == -1 {
                    SimpleDataProvider.sharedInstance.addRegatta(r) // add new
                }
                else {
                    SimpleDataProvider.sharedInstance.updateRegatta(r, atIndex:currentIndex) // update existing
                }
        }
        navigationController?.popToRootViewControllerAnimated(true) // get outta here
    }

    func initRegattas() {

        if let
            path = NSBundle.mainBundle().pathForResource("aRegattas", ofType: "json"),
            url = NSURL(fileURLWithPath: path),
            data = NSData(contentsOfURL: url),
            array = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [[String: AnyObject]] {
                regattaTypeList = array
        }
    }

    @IBAction func requestSelector(sender: UIButton) {

        let alertController = UIAlertController(title: "Art der Regatta", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)

        if let array = regattaTypeList {
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
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
        
    }

    func setSelectedRegattaType(title: String) {
        if let array = regattaTypeList {
            for regatta in array {
                if let regattaTitle = regatta["title"] as? String {
                    if regattaTitle == title {
                        NSUserDefaults.standardUserDefaults().setObject(regatta, forKey: "selectedRegatta")
                        selectorButton.setTitle(title, forState: UIControlState.Normal)
                        break
                    }
                }
            }
        }
    }

    func calcForPosition(pos: Int, scoredBoats: Int, regattaFactor: Float) -> Float {
        if pos > scoredBoats {
            return Float(0.0)
        }

        var secondFactor = Float(0.2)
        if scoredBoats < 100 {
            secondFactor = (Float(scoredBoats) - Float(10.0)) / Float(450.0)
        }

        var ffactor = regattaFactor + secondFactor

        return (ffactor * 100.0 * ((Float(scoredBoats) + 1.0 - Float(pos)) / Float(scoredBoats)))
    }
}
