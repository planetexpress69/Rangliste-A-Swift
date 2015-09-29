//
//  RankingDetailViewController.swift
//  Rangliste-A-Swift
//
//  Created by Martin Kautz on 11.06.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import UIKit

class RankingDetailViewController: UITableViewController {

    // ---------------------------------------------------------------------------------------------
    var theDataSource: RankingEntry?
    // ---------------------------------------------------------------------------------------------

    // ---------------------------------------------------------------------------------------------
    // MARK: - Init & lifecycle
    // ---------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
    }

    // ---------------------------------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // ---------------------------------------------------------------------------------------------
    // MARK: - UITableViewDatasource protocol methods
    // ---------------------------------------------------------------------------------------------
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    // ---------------------------------------------------------------------------------------------
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return theDataSource!.numberOfRegattas()
        }
    }

    // ---------------------------------------------------------------------------------------------
    override func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(
                "SailorCell",
                forIndexPath: indexPath) as! SailorCell

            cell.selectionStyle = .None

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
                cell.totalPointsLabel.text = NSString(
                    format: "%.2f",
                    locale: NSLocale.currentLocale(),
                    totalPoints) as String
            }
            return cell
        }
        else {

            let cell = tableView.dequeueReusableCellWithIdentifier(
                "RegattaDetailCell",
                forIndexPath: indexPath) as! RegattaDetailCell

            cell.selectionStyle = .None

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

    // ---------------------------------------------------------------------------------------------
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.section == 0 ? 120.0 : 80.0
    }

    // ---------------------------------------------------------------------------------------------
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
}
