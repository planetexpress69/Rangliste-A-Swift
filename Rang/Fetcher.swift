//
//  Fetcher.swift
//  Rangliste-A-Swift
//
//  Created by Martin Kautz on 26.05.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import Foundation


class Fetcher {

    func load(completion: (([RankingEntry]) -> Void)!) {

        var urlString = "http://www.teambender.de/scrape.php"

        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)

        var task = session.dataTaskWithURL(url!) {
            (data, response, error) -> Void in

            if error != nil {
                println(error.localizedDescription)
            }
            else {
                var parsingError: NSError?

                var rankingData = NSJSONSerialization.JSONObjectWithData(
                    data,
                    options: NSJSONReadingOptions.AllowFragments,
                    error: &parsingError) as! NSArray

                var rankingEntries = [RankingEntry]()

                for record in rankingData {
                    if let record = record as? NSDictionary {
                        var rankingEntry = RankingEntry(data: record)
                        rankingEntries.append(rankingEntry)
                    }
                }

                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
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
