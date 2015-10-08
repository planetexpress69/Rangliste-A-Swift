//
//  RankingListViewController.swift
//  Rangliste-A-Swift
//
//  Created by Martin Kautz on 26.05.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import UIKit

class RankingListViewController: UIViewController,
UITableViewDelegate,
UITableViewDataSource,
UISearchResultsUpdating,
UISearchBarDelegate {

    @IBOutlet weak var theTableView: UITableView!
    var spinnr = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
    var rankingEntries = [RankingEntry]()
    var filteredRankingEntries = [RankingEntry]()
    var resultSearchController = UISearchController()

    // ---------------------------------------------------------------------------------------------
    //MARK: - View lifecycle
    // ---------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        spinnr.startAnimating()
        //self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: spinnr)

        let reloadButton = UIBarButtonItem(
            title: .fontAwesomeIconWithName(.Refresh),
            style: .Plain,
            target: self,
            action: "loadWrapper")

        let attrs = [
            NSFontAttributeName : UIFont.fontAwesomeOfSize(20),
            NSForegroundColorAttributeName : Constants.Colors.textColor
        ]

        reloadButton.setTitleTextAttributes(attrs, forState: .Normal)
        navigationItem.rightBarButtonItem = reloadButton
        navigationItem.rightBarButtonItem?.enabled = false

        title = "Rangliste"

        theTableView.setContentOffset(
            CGPointMake(0, resultSearchController.searchBar.frame.size.height),
            animated: true)

        //let navigationBar = self.navigationController?.navigationBar
        //navigationBar?.hideBottomHairline()

        //theTableView.backgroundView = nil
        theTableView.backgroundColor = .whiteColor()
        theTableView.separatorStyle = UITableViewCellSeparatorStyle.None

        theTableView.delegate = self
        theTableView.dataSource = self
        view.backgroundColor = .whiteColor()
    }

    // ---------------------------------------------------------------------------------------------
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if self.rankingEntries.count == 0 {
            loadWrapper()
        }

        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.hidesNavigationBarDuringPresentation = false
            controller.searchBar.prompt = "Ergebnisse"
            //controller.searchBar.barTintColor = .whiteColor()
            //controller.searchBar.backgroundImage = .imageWithColor(.redColor())
            controller.searchBar.translucent = false
            //controller.searchBar.tintColor = .blackColor()
            controller.searchBar.sizeToFit()
            controller.searchBar.delegate = self

            return controller
        })()

        self.resultSearchController.view.backgroundColor = .whiteColor()


        theTableView.tableHeaderView = self.resultSearchController.searchBar

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
        theTableView.reloadData()
        self.navigationItem.rightBarButtonItem?.enabled = false
        spinnr.startAnimating()
        self.rankingEntries = []
        let fetcher = Fetcher()
        fetcher.load(didLoad)
    }

    //MARK: - Data loading callback
    // ---------------------------------------------------------------------------------------------
    func didLoad(rankingEntries: [RankingEntry]) {
        self.navigationItem.rightBarButtonItem?.enabled = true
        spinnr.stopAnimating()
        self.rankingEntries = rankingEntries
        theTableView.reloadData()
        self.resultSearchController.searchBar.prompt = self.rankingEntries.count == 1 ?
            "\(self.rankingEntries.count) result" :
            "\(self.rankingEntries.count) Einträge"
    }

    //MARK: - Table view data source
    // ---------------------------------------------------------------------------------------------
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    // ---------------------------------------------------------------------------------------------
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if self.resultSearchController.active {
            return self.filteredRankingEntries.count
        } else {
            return rankingEntries.count
        }
    }

    // ---------------------------------------------------------------------------------------------
    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("RankingListCell",
            forIndexPath: indexPath) as! RankingListCell

        if self.resultSearchController.active {
            cell.nameLabel?.text =
                "\(filteredRankingEntries[indexPath.row].firstname) " +
                "\(filteredRankingEntries[indexPath.row].name)"
            cell.pointsLabel?.text = NSString(
                format: "%.2f",
                locale: NSLocale.currentLocale(),
                filteredRankingEntries[indexPath.row].totalPoints as Float) as String
            cell.posLabel?.text = "\(filteredRankingEntries[indexPath.row].pos)"
            cell.yobLabel?.text = "\(filteredRankingEntries[indexPath.row].yob)"
            cell.sailLabel?.text =
                "\(filteredRankingEntries[indexPath.row].sailCountry) " +
                "\((filteredRankingEntries[indexPath.row].sailNumber))"
            cell.clubLabel?.text = "\(filteredRankingEntries[indexPath.row].club)"
            let selectedBackgroundView = UIView(frame: cell.frame)
            selectedBackgroundView.backgroundColor = Constants.Colors.textColor
            cell.selectedBackgroundView = selectedBackgroundView
        }
        else {
            cell.nameLabel?.text =
                "\(rankingEntries[indexPath.row].firstname) " +
                "\(rankingEntries[indexPath.row].name)"
            cell.pointsLabel?.text = NSString(
                format: "%.2f",
                locale: NSLocale.currentLocale(),
                rankingEntries[indexPath.row].totalPoints as Float) as String
            cell.posLabel?.text = "\(rankingEntries[indexPath.row].pos)"
            cell.yobLabel?.text = "\(rankingEntries[indexPath.row].yob)"
            cell.sailLabel?.text =
                "\(rankingEntries[indexPath.row].sailCountry) " +
                "\((rankingEntries[indexPath.row].sailNumber))"
            cell.clubLabel?.text = "\(rankingEntries[indexPath.row].club)"
            let selectedBackgroundView = UIView(frame: cell.frame)
            selectedBackgroundView.backgroundColor = Constants.Colors.textColor
            cell.selectedBackgroundView = selectedBackgroundView

        }
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64.0
    }

    func updateSearchResultsForSearchController(searchController: UISearchController) {

        filteredRankingEntries.removeAll(keepCapacity: false)

        let searchPredicate = NSPredicate(
            format: "name CONTAINS[c] %@ OR firstname CONTAINS[c] %@ " +
            "OR yob CONTAINS[c] %@ OR club CONTAINS[c] %@ " +
            "OR sailNumber CONTAINS[c] %@",
            searchController.searchBar.text!,
            searchController.searchBar.text!,
            searchController.searchBar.text!,
            searchController.searchBar.text!,
            searchController.searchBar.text!
        )
        let array = (rankingEntries as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredRankingEntries = array as! [RankingEntry]
        theTableView.reloadData()
        if self.resultSearchController.active {
            searchController.searchBar.prompt = self.filteredRankingEntries.count == 1 ?
                "\(self.filteredRankingEntries.count) Ergebnis" :
                "\(self.filteredRankingEntries.count) Ergebnisse"
        }
        else {
            searchController.searchBar.prompt = self.rankingEntries.count == 1 ?
                "\(self.rankingEntries.count) Ergebnis" :
                "\(self.rankingEntries.count) Ergebnisse"
        }
    }

    // ---------------------------------------------------------------------------------------------
    // MARK: - Navigation
    // ---------------------------------------------------------------------------------------------
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.

        let detailVC = segue.destinationViewController as! RankingDetailViewController
        let selectedRowsIndexPath: NSIndexPath = theTableView.indexPathForSelectedRow!

        var elem: RankingEntry

        if self.resultSearchController.active {
            elem = filteredRankingEntries[selectedRowsIndexPath.row]
            self.resultSearchController.active = false

        } else {
            elem = rankingEntries[selectedRowsIndexPath.row]
        }
        theTableView.deselectRowAtIndexPath(selectedRowsIndexPath, animated: true)
        detailVC.theDataSource = elem
    }

    // ---------------------------------------------------------------------------------------------
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }




}
