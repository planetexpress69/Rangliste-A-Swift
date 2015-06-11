//
//  RankingEntry.swift
//  Rangliste-A-Swift
//
//  Created by Martin Kautz on 26.05.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import Foundation

class RankingEntry : NSObject {

    var firstname: String!
    var name: String!
    var yob: String!
    var club: String!
    var sailNumber: String!
    var sailCountry: String!
    var totalPoints: Float!
    var pos: Int!
    var listOfRegattas: [RegattaEntry]! = []

    // MARK: - Init
    // ---------------------------------------------------------------------------------------------
    init(data: NSDictionary) {
        super.init()
        firstname      = getStringFromJSON(data, key: "firstname")
        name           = getStringFromJSON(data, key: "name")
        yob            = String(getIntFromJSON(data, key: "yob"))
        club           = getStringFromJSON(data, key: "club")
        sailNumber     = getStringFromJSON(data, key: "sailNumber")
        sailCountry    = getStringFromJSON(data, key: "sailCountry")
        totalPoints    = getFloatFromJSON(data, key: "totalPoints")
        pos            = getIntFromJSON(data, key: "pos")
        listOfRegattas = getListOfRegattasFromJSON(data, key: "regatta")
    }

    // MARK: - Init
    // ---------------------------------------------------------------------------------------------
    private func getStringFromJSON(data: NSDictionary, key: String) -> String {
        if let info = data[key] as? String {
            return info
        }
        return ""
    }

    // MARK: - Typesafe data extraction
    // ---------------------------------------------------------------------------------------------
    private func getFloatFromJSON(data: NSDictionary, key: String) -> Float {
        if let info = data[key] as? Float {
            return info
        }
        return 0.0
    }

    // ---------------------------------------------------------------------------------------------
    private func getIntFromJSON(data: NSDictionary, key: String) -> Int {
        if let info = data[key] as? Int {
            return info
        }
        return 0
    }

    private func getListOfRegattasFromJSON(data: NSDictionary, key: String) -> [RegattaEntry]? {
        if let info = data[key] as? Array<Dictionary<String, AnyObject>> {
            for regattaDict: Dictionary in info {
                let regatta = RegattaEntry(data: regattaDict)
                listOfRegattas.append(regatta)
            }
            return listOfRegattas
        }
        return nil
    }

    func numberOfRegattas() -> Int {
        return listOfRegattas.count
    }

}