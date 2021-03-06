//
//  SimpleDataProvider.swift
//  Rang
//
//  Created by Martin Kautz on 21.05.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import Foundation

let kArrayKey = "storedDataArray"

class SimpleDataProvider {

    // ---------------------------------------------------------------------------------------------
    var dataStorageArray: Array<Dictionary<String, AnyObject>>
    // ---------------------------------------------------------------------------------------------

    // ---------------------------------------------------------------------------------------------
    // ---------------------------------------------------------------------------------------------
    class var sharedInstance: SimpleDataProvider {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: SimpleDataProvider? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = SimpleDataProvider()
        }
        return Static.instance!
    }

    // ---------------------------------------------------------------------------------------------
    init() {
        let userdefaults = NSUserDefaults.standardUserDefaults()
        if userdefaults.objectForKey(kArrayKey) != nil {
            dataStorageArray = userdefaults.objectForKey(kArrayKey) as! Array
            repair()
            sort()
        } else {
            dataStorageArray = []
            loadGreta()
        }
    }

    // ---------------------------------------------------------------------------------------------
    func addRegatta(regatta: Dictionary<String, AnyObject>) {
        dataStorageArray.append(regatta)
        self.sort()
        NSUserDefaults.standardUserDefaults().setObject(dataStorageArray, forKey: kArrayKey)
    }

    // ---------------------------------------------------------------------------------------------
    func updateRegatta(regatta: Dictionary<String, AnyObject>, atIndex:NSInteger) {
        dataStorageArray.removeAtIndex(atIndex)
        dataStorageArray.insert(regatta, atIndex: atIndex)
        self.sort()
        NSUserDefaults.standardUserDefaults().setObject(dataStorageArray, forKey: kArrayKey)
    }

    // ---------------------------------------------------------------------------------------------
    func removeRegattaAtIndex(index: Int) {
        dataStorageArray.removeAtIndex(index)
        NSUserDefaults.standardUserDefaults().setObject(dataStorageArray, forKey: kArrayKey)
    }

    // ---------------------------------------------------------------------------------------------
    func loadGreta() -> () {
        if let
            path     = NSBundle.mainBundle().pathForResource("sample", ofType: "json"),
            url: NSURL = NSURL(fileURLWithPath: path),
            data = NSData(contentsOfURL: url),
            array = (try? NSJSONSerialization.JSONObjectWithData(
                data,
                options: [])) as? [[String: AnyObject]] {
                dataStorageArray = array
                NSUserDefaults.standardUserDefaults().setObject(dataStorageArray, forKey: kArrayKey)
            }

        sort()
    }

    // ---------------------------------------------------------------------------------------------
    func bestScoreA() -> Float {

        if dataStorageArray.count == 0 {
            return 0.0
        }

        var counter = 0
        var allPoints: Float = 0.0
        //var regatta = [ : ]

        for regatta in dataStorageArray {

            let score = regatta["score"] as! Float
            let races = regatta["races"] as! Int
            let threeDays = regatta["threeDays"] as! Bool
            let mFactor = calcmFactor(races, atLeastThreeDays: threeDays)

            for var index = 0; index < mFactor; index++ {
                if (counter < 9) {
                    counter++
                    allPoints += score;
                }
            }
        }

        if counter == 9 {
            let result: Float = Float(allPoints) / Float(counter)
            return result
        }
        return 0.0

    }

    // ---------------------------------------------------------------------------------------------
    func calcmFactor(races: Int, atLeastThreeDays: Bool) -> Int {

        if races < 5 {
            return races
        }

        if races == 5 {
            return 4
        }

        return atLeastThreeDays ? 5 : 4

    }

    // ---------------------------------------------------------------------------------------------
    func sort() {
        dataStorageArray.sortInPlace {
            item1, item2 in
            let item1 = item1["score"] as! Double
            let item2 = item2["score"] as! Double
            return item1 > item2
        }
    }

    // ---------------------------------------------------------------------------------------------
    // MARK: - Fixing data types - accuse former Martin!
    // ---------------------------------------------------------------------------------------------
    func repair() {

        var newArray = [[String : AnyObject]]()
        let c = 0

        for regatta in dataStorageArray {
            var newRegatta: Dictionary = regatta

            let name = regatta["title"] as! String
            let newName = newRegatta["title"] as! String


            print("   regatta: \(name)")
            print("newRegatta: \(newName)")
            print("*********************************")

            if let races = regatta["races"] as? String {
                print("Repairing races...")
                let iraces: Int = Int(races)!
                newRegatta["races"] = iraces
            }

            if let pos = regatta["pos"] as? String {
                print("Repairing pos...")
                let ipos: Int = Int(pos)!
                newRegatta["pos"] = ipos
            }

            if let field = regatta["field"] as? String {
                print("Repairing field...")
                let ifield: Int = Int(field)!
                newRegatta["field"] = ifield
            }
            newArray.insert(newRegatta, atIndex: c)
            dataStorageArray = newArray
        }
        print("Updating...")
        NSUserDefaults.standardUserDefaults().setObject(newArray, forKey: kArrayKey)
    }
}