//
//  RegattaListViewController.swift
//  Rang
//
//  Created by Martin Kautz on 19.05.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import UIKit

class RegattaListViewController: UITableViewController {

    var listOfRegattas: [Dictionary<String, AnyObject>] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        clearsSelectionOnViewWillAppear = true
        title = "Deine Regatten"
        navigationItem.leftBarButtonItem = editButtonItem()
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .Plain,
            target:
            nil,
            action: nil)
    }

    // ---------------------------------------------------------------------------------------------
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        listOfRegattas = SimpleDataProvider.sharedInstance.dataStorageArray
        tableView.reloadData()
    }

    // ---------------------------------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    // ---------------------------------------------------------------------------------------------
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    // ---------------------------------------------------------------------------------------------
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return listOfRegattas.count
    }

    // ---------------------------------------------------------------------------------------------
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RegattaListCell",
            forIndexPath: indexPath) as! RegattaListCell
        var selectedBackgroundView = UIView(frame: CGRectMake(0, 0, 320, 100))
        selectedBackgroundView.backgroundColor = Constants.Colors.darkBlue
        cell.selectedBackgroundView = selectedBackgroundView
        cell.regattaNameLabel!.text = listOfRegattas[indexPath.row]["name"] as? String

        cell.pointsLabel!.text = NSString(
            format: "%.3f",
            locale: NSLocale.currentLocale(),
            calcPoints()
            ) as String
        cell.regattaFactorLabel!.text = NSString(
            format: "%d",
            locale: NSLocale.currentLocale(),
            listOfRegattas[indexPath.row]["numberOfRaces"] as! Int
            ) as String
        cell.positionLabel!.text = NSString(
            format: "%d/%d",
            locale: NSLocale.currentLocale(),
            listOfRegattas[indexPath.row]["position"] as! Int,
            listOfRegattas[indexPath.row]["numberOfTimedBoats"] as! Int
            ) as String
        return cell
    }

    // ---------------------------------------------------------------------------------------------
    override func tableView(tableView: UITableView,
        canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }

    // ---------------------------------------------------------------------------------------------
    override func tableView(tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            SimpleDataProvider.sharedInstance.removeRegattaAtIndex(indexPath.row)
            listOfRegattas.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            //Create a new instance of the appropriate class, 
            //insert it into the array, and add a new row to the table view
        }    
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
                let indexPath = tableView.indexPathForCell(sender as! RegattaListCell)
                detailViewController.loadRegattaWithIndex(indexPath!.row)
            }
    }

    // ---------------------------------------------------------------------------------------------
    override func tableView(tableView: UITableView,
        heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }

    // ---------------------------------------------------------------------------------------------
    override func tableView(
        tableView: UITableView,
        heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }

    // ---------------------------------------------------------------------------------------------
    override func tableView(
        tableView: UITableView,
        viewForHeaderInSection section: Int) -> UIView? {
        var headerLabel = UILabel(frame: CGRectMake(
            15,
            0,
            tableView.frame.size.width - 30,
            100))
        headerLabel.font = UIFont(
            name: "HelveticaNeue-Bold",
            size: 72)
        headerLabel.textColor = Constants.Colors.darkBlue
        headerLabel.text = NSString(
            format: "%.3f",
            locale: NSLocale.currentLocale(),
            calcTotalPoins()) as String

        var headerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 100))
        headerView.addSubview(headerLabel)

        return headerView
    }

    // ---------------------------------------------------------------------------------------------
    func calcPoints() -> Float {
        return 77.777
    }

    // ---------------------------------------------------------------------------------------------
    func calcTotalPoins() -> Float {
        return 99.999
    }

}
