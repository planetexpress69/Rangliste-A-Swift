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
        regattaNameTextField.textColor = Constants.Colors.textColor

        regattaPosTextField.delegate = self
        regattaPosTextField.keyboardType = .NumberPad
        regattaPosTextField.autocapitalizationType = .None
        regattaPosTextField.autocorrectionType = .No
        regattaPosTextField.returnKeyType = .Next
        regattaPosTextField.textColor = Constants.Colors.textColor

        regattaFieldTextField.delegate = self
        regattaFieldTextField.keyboardType = .NumberPad
        regattaFieldTextField.autocapitalizationType = .None
        regattaFieldTextField.autocorrectionType = .No
        regattaFieldTextField.returnKeyType = .Next
        regattaFieldTextField.textColor = Constants.Colors.textColor

        regattaRacesTextField.delegate = self
        regattaRacesTextField.keyboardType = .NumberPad
        regattaRacesTextField.autocapitalizationType = .None
        regattaRacesTextField.autocorrectionType = .No
        regattaRacesTextField.returnKeyType = .Next
        regattaRacesTextField.textColor = Constants.Colors.textColor

        selectorButton.titleLabel?.font = .systemFontOfSize(16.0)

        selectorButton.setBackgroundImage(
            .imageWithColor(Constants.Colors.textColor),
            forState: .Normal)

        selectorButton.setBackgroundImage(
            .imageWithColor(Constants.Colors.textColor),
            forState: .Highlighted)

        selectorButton.setBackgroundImage(
            .imageWithColor(.whiteColor()),
            forState: .Disabled)

        selectorButton.setTitleColor(
            .whiteColor(),
            forState: .Normal)

        selectorButton.setTitleColor(
            .whiteColor(),
            forState: .Highlighted)

        selectorButton.setTitleColor(
            Constants.Colors.textColor,
            forState: .Disabled)

        selectorButton.layer.cornerRadius = selectorButton.frame.size.height / 2
        selectorButton.layer.borderWidth = 0
        selectorButton.clipsToBounds = true

        selectorButton.addTarget(
            self,
            action: "requestSelector:",
            forControlEvents: .TouchUpInside)

        let editButton = UIBarButtonItem(title: .fontAwesomeIconWithName(.Edit),
            style: .Plain,
            target: self,
            action: "toggleEdit:")
        let attrs = [
            NSFontAttributeName : UIFont.fontAwesomeOfSize(20),
            NSForegroundColorAttributeName : Constants.Colors.textColor
        ]
        editButton.setTitleTextAttributes(
            attrs,
            forState: .Normal)

        navigationItem.rightBarButtonItem = editButton

        threeDaysButton.titleLabel?.font = .fontAwesomeOfSize(20)

        threeDaysButton.setTitle(
            .fontAwesomeIconWithName(.CheckSquareO),
            forState: .Normal)

        threeDaysButton.setTitleColor(
            Constants.Colors.textColor,
            forState: .Normal)

        threeDaysButton.addTarget(
            self,
            action: "toggleThreeDays:",
            forControlEvents: .TouchUpInside)
    }

    // ---------------------------------------------------------------------------------------------
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        if currentIndex == -1 {
            setEditing(true, animated: true)
            isThreeDays = false
            threeDaysButton.setTitle(.fontAwesomeIconWithName(.SquareO), forState: .Normal)
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
            threeDaysButton.setTitle(threeDays ?
                .fontAwesomeIconWithName(.CheckSquareO) :
                .fontAwesomeIconWithName(.SquareO), forState: .Normal)
            setEditing(false, animated: true)
        }

        initRegattas()

        if let
            selRegatta = NSUserDefaults.standardUserDefaults().objectForKey("selectedRegatta") as?
                Dictionary<String, AnyObject>,
            title = selRegatta["title"] as? String {
                selectorButton.setTitle(title, forState: .Normal)
        }
        else {
            if let
                firstRegatta = regattaTypeList?[0]  {
                    NSUserDefaults.standardUserDefaults().setObject(
                        firstRegatta,
                        forKey: "selectedRegatta")
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
            .fontAwesomeIconWithName(.CheckSquareO) :
            .fontAwesomeIconWithName(.SquareO),
            forState: .Normal)
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

            let editButton = UIBarButtonItem(title: .fontAwesomeIconWithName(.Check),
                style: .Plain,
                target: self,
                action: "toggleEdit:")
            let attrs = [
                NSFontAttributeName : UIFont.fontAwesomeOfSize(20),
                NSForegroundColorAttributeName : Constants.Colors.textColor
            ]
            editButton.setTitleTextAttributes(attrs, forState: .Normal)
            navigationItem.rightBarButtonItem = editButton
        }
        else {

            regattaNameTextField.userInteractionEnabled    = false
            regattaNameTextField.borderStyle               = .None

            regattaPosTextField.userInteractionEnabled     = false
            regattaPosTextField.borderStyle                = .None

            regattaFieldTextField.userInteractionEnabled   = false
            regattaFieldTextField.borderStyle              = .None

            regattaRacesTextField.userInteractionEnabled   = false
            regattaRacesTextField.borderStyle              = .None

            threeDaysButton.userInteractionEnabled         = false

            //dSelectedRegatta                               = nil

            selectorButton.enabled                          = false
            selectorButton.titleLabel!.textColor             = .grayColor()

            let editButton = UIBarButtonItem(title: .fontAwesomeIconWithName(.Edit),
                style: .Plain,
                target: self,
                action: "toggleEdit:")
            let attrs = [
                NSFontAttributeName : UIFont.fontAwesomeOfSize(20),
                NSForegroundColorAttributeName : Constants.Colors.textColor
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
            td = theRegatta["threeDays"] as? Bool {
                threeDays = td

        }

        if currentIndex != -1 {
            threeDays = isThreeDays
        }

        var f = Float(1.0)

        let userDefaults = NSUserDefaults.standardUserDefaults()

        if let
            selRegatta: AnyObject = userDefaults.objectForKey("selectedRegatta"),
            dict: Dictionary<String, AnyObject> = selRegatta as? Dictionary,
            factor: Float = dict["factor"] as? Float {
                f = factor
        }

        if let
            pos = Int(position),
            field = Int(numberOfTimedBoats),
            races = Int(numberOfRaces) {
                let r: Dictionary<String, AnyObject> = [
                    "title" : name,
                    "pos" : pos,
                    "field" : field,
                    "races" : races,
                    "threeDays" : threeDays,
                    "score" : calcScoreForPosition(pos, scoredBoats: field, regattaFactor: f)
                ]
                if currentIndex == -1 {
                    // add new
                    SimpleDataProvider.sharedInstance.addRegatta(r)
                }
                else {
                    // update existing
                    SimpleDataProvider.sharedInstance.updateRegatta(r, atIndex:currentIndex)
                }
        }
        navigationController?.popToRootViewControllerAnimated(true)
    }


    //MARK: - Load regatta types from JSON
    // ---------------------------------------------------------------------------------------------
    func initRegattas() {

        if let
            path = NSBundle.mainBundle().pathForResource("aRegattas", ofType: "json"),
            url: NSURL = NSURL(fileURLWithPath: path),
            data = NSData(contentsOfURL: url),
            array = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as?
                [[String: AnyObject]] {
                regattaTypeList = array
        }
    }


    //MARK: - Handle selector button
    // ---------------------------------------------------------------------------------------------
    @IBAction func requestSelector(sender: UIButton) {

        let alertController = UIAlertController(
            title: "Art der Regatta",
            message: nil, preferredStyle: .ActionSheet)

        if let array = regattaTypeList {
            for regatta in array {
                let action = UIAlertAction(
                    title: regatta["title"] as? String,
                    style: .Default,
                    handler: {
                        (alert: UIAlertAction) in self.setSelectedRegattaType(alert.title!)
                    }
                )
                alertController.addAction(action)
            }
        }

        if let _ = alertController.popoverPresentationController {
            //iPad
            alertController.popoverPresentationController!.sourceView = sender;
            alertController.popoverPresentationController!.sourceRect = CGRectMake(
                sender.bounds.size.width / 2.0,
                60,
                1.0,
                1.0);
        } else {
            //iPhone
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) {
                (action) in
                // ...
            }
            alertController.addAction(cancelAction)
        }

        self.presentViewController(alertController, animated: true) {

        }
    }

    //MARK: - Set selected regatta type
    // ---------------------------------------------------------------------------------------------
    func setSelectedRegattaType(title: String) {
        if let array = regattaTypeList {
            for regatta in array {
                if let regattaTitle = regatta["title"] as? String {
                    if regattaTitle == title {
                        NSUserDefaults.standardUserDefaults().setObject(
                            regatta,
                            forKey: "selectedRegatta")
                        selectorButton.setTitle(title, forState: .Normal)
                        break
                    }
                }
            }
        }
    }

    //MARK: - Actual calculation
    // ---------------------------------------------------------------------------------------------
    func calcScoreForPosition(pos: Int, scoredBoats: Int, regattaFactor: Float) -> Float {

        if pos > scoredBoats {
            return Float(0.0)
        }

        var secondFactor = Float(0.2)
        if scoredBoats < 100 {
            secondFactor = (Float(scoredBoats) - Float(10.0)) / Float(450.0)
        }
        let ffactor = regattaFactor + secondFactor
        return (ffactor * 100.0 * ((Float(scoredBoats) + 1.0 - Float(pos)) / Float(scoredBoats)))
    }

    // ---------------------------------------------------------------------------------------------
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }

}
