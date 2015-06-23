//
//  RankingListViewController.swift
//  Rangliste-A-Swift
//
//  Created by Martin Kautz on 26.05.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import UIKit

class RankingListViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {

    var spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
    var rankingEntries: [RankingEntry] = [RankingEntry]()
    var filteredRankingEntries: [RankingEntry] = [RankingEntry]()
    var resultSearchController = UISearchController()

    //MARK: - View lifecycle
    // ---------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: spinner!)

        let reloadButton = UIBarButtonItem(title: String.fontAwesomeIconWithName(FontAwesome.Refresh),
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "loadWrapper")
        var attrs = [
            NSFontAttributeName : UIFont.fontAwesomeOfSize(20),
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        reloadButton.setTitleTextAttributes(attrs, forState: .Normal)
        navigationItem.rightBarButtonItem = reloadButton
        navigationItem.rightBarButtonItem?.enabled = false

        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.hidesNavigationBarDuringPresentation = false
            controller.searchBar.prompt = "Results"
            controller.searchBar.sizeToFit()
            controller.searchBar.delegate = self

            self.tableView.tableHeaderView = controller.searchBar

            return controller
        })()

        title = "Rangliste"

        self.tableView.setContentOffset(CGPointMake (0, resultSearchController.searchBar.frame.size.height), animated: true)
    }

    // ---------------------------------------------------------------------------------------------
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if self.rankingEntries.count == 0 {
            loadWrapper()
        }
    }

    // ---------------------------------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Data loading wrapper
    // ---------------------------------------------------------------------------------------------
    func loadWrapper() {
        self.rankingEntries = []
        tableView.reloadData()
        self.navigationItem.rightBarButtonItem?.enabled = false
        spinner.startAnimating()
        self.rankingEntries = []
        let fetcher = Fetcher()
        fetcher.load(didLoad)
    }

    //MARK: - Data loading callback
    // ---------------------------------------------------------------------------------------------
    func didLoad(rankingEntries: [RankingEntry]) {
        self.navigationItem.rightBarButtonItem?.enabled = true
        spinner?.stopAnimating()
        self.rankingEntries = rankingEntries
        tableView.reloadData()
        self.resultSearchController.searchBar.prompt = self.rankingEntries.count == 1 ? "\(self.rankingEntries.count) result" : "\(self.rankingEntries.count) results"

    }


    //MARK: - Table view data source
    // ---------------------------------------------------------------------------------------------
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    // ---------------------------------------------------------------------------------------------
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if self.resultSearchController.active {
            return self.filteredRankingEntries.count
        } else {
            return rankingEntries.count
        }
    }

    // ---------------------------------------------------------------------------------------------
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("RankingListCell", forIndexPath: indexPath) as! RankingListCell

        if self.resultSearchController.active {

            cell.nameLabel?.text = "\(filteredRankingEntries[indexPath.row].firstname) \(filteredRankingEntries[indexPath.row].name)"
            cell.pointsLabel?.text = NSString(format: "%.3f", locale: NSLocale.currentLocale(), filteredRankingEntries[indexPath.row].totalPoints as Float) as String
            cell.posLabel?.text = "\(filteredRankingEntries[indexPath.row].pos)"
            cell.yobLabel?.text = "\(filteredRankingEntries[indexPath.row].yob)"
            cell.sailLabel?.text = "\(filteredRankingEntries[indexPath.row].sailCountry) \((filteredRankingEntries[indexPath.row].sailNumber))"
            cell.clubLabel?.text = "\(filteredRankingEntries[indexPath.row].club)"
            let selectedBackgroundView = UIView(frame: cell.frame)
            selectedBackgroundView.backgroundColor = Constants.Colors.darkBlue
            cell.selectedBackgroundView = selectedBackgroundView
        }
        else {

            cell.nameLabel?.text = "\(rankingEntries[indexPath.row].firstname) \(rankingEntries[indexPath.row].name)"
            cell.pointsLabel?.text = NSString(format: "%.3f", locale: NSLocale.currentLocale(), rankingEntries[indexPath.row].totalPoints as Float) as String
            cell.posLabel?.text = "\(rankingEntries[indexPath.row].pos)"
            cell.yobLabel?.text = "\(rankingEntries[indexPath.row].yob)"
            cell.sailLabel?.text = "\(rankingEntries[indexPath.row].sailCountry) \((rankingEntries[indexPath.row].sailNumber))"
            cell.clubLabel?.text = "\(rankingEntries[indexPath.row].club)"
            let selectedBackgroundView = UIView(frame: cell.frame)
            selectedBackgroundView.backgroundColor = Constants.Colors.darkBlue
            cell.selectedBackgroundView = selectedBackgroundView
            
        }
        return cell
    }

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filteredRankingEntries.removeAll(keepCapacity: false)
        let searchPredicate = NSPredicate(format: "name CONTAINS[c] %@ OR firstname CONTAINS[c] %@ OR yob CONTAINS[c] %@ OR club CONTAINS[c] %@ OR sailNumber CONTAINS[c] %@",
            searchController.searchBar.text,
            searchController.searchBar.text,
            searchController.searchBar.text,
            searchController.searchBar.text,
            searchController.searchBar.text
        )
        let array = (rankingEntries as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredRankingEntries = array as! [RankingEntry]
        self.tableView.reloadData()
        if self.resultSearchController.active {
            searchController.searchBar.prompt = self.filteredRankingEntries.count == 1 ? "\(self.filteredRankingEntries.count) result" : "\(self.filteredRankingEntries.count) results"
        }
        else {
            searchController.searchBar.prompt = self.rankingEntries.count == 1 ? "\(self.rankingEntries.count) result" : "\(self.rankingEntries.count) results"
        }

    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.

        var rankingDetailViewController = segue.destinationViewController as! RankingDetailViewController
        let selectedRowsIndexPath: NSIndexPath = tableView.indexPathForSelectedRow()!

        var elem: RankingEntry

        if self.resultSearchController.active {
            elem = filteredRankingEntries[selectedRowsIndexPath.row]
            self.resultSearchController.active = false;

        } else {
            elem = rankingEntries[selectedRowsIndexPath.row];
        }
        tableView.deselectRowAtIndexPath(selectedRowsIndexPath, animated: true)
        rankingDetailViewController.theDataSource = elem
    }
    


}
