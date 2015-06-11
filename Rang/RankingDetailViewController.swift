//
//  RankingDetailViewController.swift
//  Rangliste-A-Swift
//
//  Created by Martin Kautz on 11.06.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import UIKit

class RankingDetailViewController: UITableViewController {

    var theDataSource: RankingEntry?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.

        switch section {
        case 0:
            return 1
        default:
            return theDataSource!.numberOfRegattas()
        }

   }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {


        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("SailorCell", forIndexPath: indexPath) as! SailorCell

            if let
                firstName = theDataSource?.firstname,
                name = theDataSource?.name {
                    cell.firstnamenameLabel.text = "\(firstName) \(name)"
            }

            if let club = theDataSource?.club {
                cell.clubLabel.text = club
            }

            if let yob = theDataSource?.yob {
                cell.yobLabel.text = String(yob)
            }

            if let sailCountry = theDataSource?.sailCountry {
                cell.sailCountryLabel.text = sailCountry
            }

            if let sailNumber = theDataSource?.sailNumber {
                cell.sailNumberLabel.text = sailNumber
            }

            if let pos = theDataSource?.pos {
                cell.posLabel.text = String(pos)
            }

            if let totalPoints = theDataSource?.totalPoints {
                cell.totalPointsLabel.text = "\(totalPoints)"
            }
            


            return cell
        }
        else {

            let cell = tableView.dequeueReusableCellWithIdentifier("RegattaDetailCell", forIndexPath: indexPath) as! RegattaDetailCell

            cell.rnameLabel.text = theDataSource?.listOfRegattas[indexPath.row].rname

            if let
                boats = theDataSource?.listOfRegattas[indexPath.row].boats,
                pos = theDataSource?.listOfRegattas[indexPath.row].position {
                    cell.positionboatsLabel.text = "\(pos)/\(boats)" as String!
            }

            if let runs_scored = theDataSource?.listOfRegattas[indexPath.row].runs_scored {
                cell.runs_scoredLabel.text = "\(runs_scored)" as String
            }

            if let runs_total = theDataSource?.listOfRegattas[indexPath.row].runs_total {
                cell.runs_totalLabel.text = "\(runs_total)" as String
            }

            if let sl_points = theDataSource?.listOfRegattas[indexPath.row].sl_points {
                cell.sl_pointsLabel.text = "\(sl_points)" as String
            }

            if let sl_points_cup = theDataSource?.listOfRegattas[indexPath.row].sl_points_cup {
                cell.sl_points_cupLabel.text = "\(sl_points_cup)" as String
            }

            return cell
        }

    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    /*
    //----------------------------------------------------------------------------------------------------------------------
    #pragma mark - UITableViewDelegate protocol methods
    //----------------------------------------------------------------------------------------------------------------------
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
    return indexPath.section == 0 ? 120.0f : 80.0f;
    }

    */

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.section == 0 ? 120.0 : 80.0
    }

}
