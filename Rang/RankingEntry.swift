//
//  RankingEntry.swift
//  Rangliste-A-Swift
//
//  Created by Martin Kautz on 26.05.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import Foundation

class RankingEntry {

    var firstname: String!
    var name: String!
    var yob: String!
    var club: String!
    var sailNumber: String!
    var sailCountry: String!
    var totalPoints: Float!
    var pos: Int!

    // MARK: - Init
    // ---------------------------------------------------------------------------------------------
    init(data: NSDictionary) {
        self.firstname      = getStringFromJSON(data, key: "firstname")
        self.name           = getStringFromJSON(data, key: "name")
        self.yob            = getStringFromJSON(data, key: "yob")
        self.club           = getStringFromJSON(data, key: "club")
        self.sailNumber     = getStringFromJSON(data, key: "sailNumber")
        self.sailCountry    = getStringFromJSON(data, key: "sailCountry")
        self.totalPoints    = getFloatFromJSON(data, key: "totalPoints")
        self.pos            = getIntFromJSON(data, key: "pos")
    }

    // MARK: - Init
    // ---------------------------------------------------------------------------------------------
    func getStringFromJSON(data: NSDictionary, key: String) -> String {
        if let info = data[key] as? String {
            return info
        }
        return ""
    }

    // MARK: - Typesafe data extraction
    // ---------------------------------------------------------------------------------------------
    func getFloatFromJSON(data: NSDictionary, key: String) -> Float {
        if let info = data[key] as? Float {
            return info
        }
        return 0.0
    }

    // ---------------------------------------------------------------------------------------------
    func getIntFromJSON(data: NSDictionary, key: String) -> Int {
        if let info = data[key] as? Int {
            return info
        }
        return 0
    }

}