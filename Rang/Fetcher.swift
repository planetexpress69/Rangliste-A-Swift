//
//  Fetcher.swift
//  Rangliste-A-Swift
//
//  Created by Martin Kautz on 26.05.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import Foundation


class Fetcher {

    // ---------------------------------------------------------------------------------------------
    // MARK: - Load data
    // ---------------------------------------------------------------------------------------------
    func load(completion: (([RankingEntry]) -> Void)!) {

        let session = NSURLSession.sharedSession()
        let urlString = "http://www.teambender.de/scrape.php"
        let url = NSURL(string: urlString)
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        let task = session.dataTaskWithURL(url!) {
            (data, response, error) -> Void in

            if error != nil {
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    dispatch_async(dispatch_get_main_queue()) {
                        completion([]) // simply returning an empty array
                    }
                }
            }
            else {
                var rankingData = []

                do {
                    let gottenData: AnyObject = try NSJSONSerialization.JSONObjectWithData(
                        data!,
                        options: NSJSONReadingOptions.AllowFragments)
                        rankingData = gottenData as! NSArray
                } catch let error as NSError {
                    print("Error: \(error)")
                } catch {
                    fatalError()
                }

                var rankingEntries = [RankingEntry]()

                for record in rankingData {
                    if let record = record as? NSDictionary {
                        let rankingEntry = RankingEntry(data: record)
                        rankingEntries.append(rankingEntry)
                    }
                }

                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(rankingEntries)
                    }
                }
            }
        }
        task.resume()
    }
}
