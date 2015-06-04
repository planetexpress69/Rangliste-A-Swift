//
//  RankingListViewController.swift
//  Rangliste-A-Swift
//
//  Created by Martin Kautz on 26.05.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import UIKit

class RankingListViewController: UITableViewController {

    var spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
    var rankingEntries :[RankingEntry] = [RankingEntry]()

    //MARK: - View lifecycle
    // ---------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        spinner.startAnimating()
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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

        title = "Rangliste"
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
        loadWrapper()
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
        return rankingEntries.count
    }

    // ---------------------------------------------------------------------------------------------
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("RankingListCell", forIndexPath: indexPath) as! RankingListCell
        cell.nameLabel?.text = "\(rankingEntries[indexPath.row].firstname) \(rankingEntries[indexPath.row].name)"
        cell.pointsLabel?.text = NSString(format: "%.3f", locale: NSLocale.currentLocale(), rankingEntries[indexPath.row].totalPoints as Float) as String
        cell.posLabel?.text = "\(rankingEntries[indexPath.row].pos)"
        cell.yobLabel?.text = "\(rankingEntries[indexPath.row].yob)"
        cell.sailLabel?.text = "\(rankingEntries[indexPath.row].sailCountry) \((rankingEntries[indexPath.row].sailNumber))"
        cell.clubLabel?.text = "\(rankingEntries[indexPath.row].club)"

        let selectedBackgroundView = UIView(frame: cell.frame)
        selectedBackgroundView.backgroundColor = Constants.Colors.darkBlue
        cell.selectedBackgroundView = selectedBackgroundView

        return cell

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */


}
