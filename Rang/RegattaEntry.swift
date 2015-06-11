//
//  RegattaEntry.swift
//  Rangliste-A-Swift
//
//  Created by Martin Kautz on 11.06.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import UIKit

class RegattaEntry: NSObject {

    var sl_points: Float!
    var sl_points_cup: Float!
    var rname: String!
    var runs_total: Int!
    var boats: Int!
    var position: Int!
    var runs_scored: Int!

    init(data: Dictionary<String, AnyObject>){
        super.init()
        /* [dsv: BW089, regattaId: 2015A003, sail_number: 12542, sail_country: GER, sl_points: 5.37, rname: Lahrer Opti-Pokal, runs_total: 5, boats: 19, position: 19, sl_points_cup: 5.26, runs_scored: 4, flags: 0] */

        sl_points = getFloatFromJSON(data, key: "sl_points")
        sl_points_cup = getFloatFromJSON(data, key: "sl_points_cup")
        rname = getStringFromJSON(data, key: "rname")
        runs_total = getIntFromJSON(data, key: "runs_total")
        boats = getIntFromJSON(data, key: "boats")
        position = getIntFromJSON(data, key: "position")
        runs_scored = getIntFromJSON(data, key: "runs_scored")

    }

    private func getIntFromJSON(data: Dictionary<String, AnyObject>, key: String) -> Int {
        if let info = data[key] as? Int {
            return info
        }
        return 0
    }

    private func getStringFromJSON(data: Dictionary<String, AnyObject>, key: String) -> String {
        if let info = data[key] as? String {
            return info
        }
        return ""
    }

    private func getFloatFromJSON(data: Dictionary<String, AnyObject>, key: String) -> Float {
        if let info = data[key] as? Float {
            return info
        }
        return 0.0
    }
    
}
