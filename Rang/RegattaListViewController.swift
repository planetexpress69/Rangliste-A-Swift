//
//  RegattaListViewController.swift
//  Rang
//
//  Created by Martin Kautz on 19.05.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import UIKit

class RegattaListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // ---------------------------------------------------------------------------------------------
    @IBOutlet weak var theScoreView: UIView!
    @IBOutlet weak var theScoreLabel: UILabel!
    @IBOutlet weak var theTableView: UITableView!
    // ---------------------------------------------------------------------------------------------
    var listOfRegattas: [Dictionary<String, AnyObject>] = []
    // ---------------------------------------------------------------------------------------------

    // MARK: - View's lifecycle
    // ---------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Deine Regatten"
        navigationItem.leftBarButtonItem = editButtonItem()

        var addButton = UIBarButtonItem(
            title: String.fontAwesomeIconWithName(.PlusCircle),
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "addRegatta:")
        var attrs = [
            NSFontAttributeName : UIFont.fontAwesomeOfSize(20),
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]

        addButton.setTitleTextAttributes(attrs, forState: .Normal)
        navigationItem.rightBarButtonItem = addButton

        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .Plain,
            target: nil,
            action: nil)

        theTableView?.backgroundColor = Constants.Colors.darkBlue
        theTableView?.delegate = self;
        theTableView?.dataSource = self;

        theScoreView.backgroundColor = Constants.Colors.darkBlue

        var navigationBar = self.navigationController?.navigationBar
        navigationBar?.hideBottomHairline()

        self.theTableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0);
    }

    // ---------------------------------------------------------------------------------------------
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        listOfRegattas = SimpleDataProvider.sharedInstance.dataStorageArray
        theTableView?.reloadData()
        updateTotalPoints()
    }

    // MARK: - Table view data source
    // ---------------------------------------------------------------------------------------------
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    // ---------------------------------------------------------------------------------------------
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return listOfRegattas.count
    }

    // ---------------------------------------------------------------------------------------------
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("RegattaListCell",
                forIndexPath: indexPath) as! RegattaListCell
            var selectedBackgroundView = UIView(frame: CGRectMake(0, 0, 320, 100))
            selectedBackgroundView.backgroundColor = Constants.Colors.darkBlue
            cell.selectedBackgroundView = selectedBackgroundView
            cell.regattaNameLabel!.text = listOfRegattas[indexPath.row]["title"] as? String

            cell.pointsLabel!.text = NSString(
                format: "%.3f",
                locale: NSLocale.currentLocale(),
                listOfRegattas[indexPath.row]["score"] as! Float
                ) as String

            var factor = SimpleDataProvider.sharedInstance.calcmFactor(listOfRegattas[indexPath.row]["races"] as! Int, atLeastThreeDays: listOfRegattas[indexPath.row]["threeDays"] as! Bool)

            cell.regattaFactorLabel!.text = NSString(
                format: "%d",
                locale: NSLocale.currentLocale(),
                factor as Int
                ) as String
            cell.positionLabel!.text = NSString(
                format: "%d/%d",
                locale: NSLocale.currentLocale(),
                listOfRegattas[indexPath.row]["pos"] as! Int,
                listOfRegattas[indexPath.row]["field"] as! Int
                ) as String
            return cell
    }

    // ---------------------------------------------------------------------------------------------
    func tableView(tableView: UITableView,
        canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
            return true
    }

    // ---------------------------------------------------------------------------------------------
    func tableView(tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {
            if editingStyle == .Delete {
                SimpleDataProvider.sharedInstance.removeRegattaAtIndex(indexPath.row)
                listOfRegattas.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                updateTotalPoints()
            }
    }

    // MARK: - Table view delegate
    // ---------------------------------------------------------------------------------------------
    func tableView(tableView: UITableView,
        heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 80.0
    }

    // MARK: - Navigation
    // ---------------------------------------------------------------------------------------------
    override func prepareForSegue(
        segue: UIStoryboardSegue,
        sender: AnyObject?) {
            switch segue.identifier! {
            case "addSegue":
                var detailViewController =
                segue.destinationViewController as! RegattaDetailViewController
                detailViewController.loadRegattaWithIndex(-1)
            default:
                var detailViewController =
                segue.destinationViewController as! RegattaDetailViewController
                let indexPath = theTableView.indexPathForCell(sender as! RegattaListCell)
                detailViewController.loadRegattaWithIndex(indexPath!.row)
            }
    }

    // ---------------------------------------------------------------------------------------------
    func addRegatta(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("addSegue", sender: nil)
    }

    // ---------------------------------------------------------------------------------------------
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        theTableView.setEditing(editing, animated: animated)
    }

    // MARK: - Calculation
    // ---------------------------------------------------------------------------------------------
    func calcTotalPoints() -> Float {
        return SimpleDataProvider.sharedInstance.bestScoreA()
    }

    // ---------------------------------------------------------------------------------------------
    func updateTotalPoints() -> () {
        theScoreLabel.text = NSString(
            format: "%.3f",
            locale: NSLocale.currentLocale(),
            calcTotalPoints()) as String
    }
}
