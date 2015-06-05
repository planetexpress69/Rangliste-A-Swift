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

    var dataStorageArray: Array<Dictionary<String, AnyObject>>

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

    init() {
        var userdefaults = NSUserDefaults.standardUserDefaults()
        if userdefaults.objectForKey(kArrayKey) != nil {
            dataStorageArray = userdefaults.objectForKey(kArrayKey) as! Array
        } else {
            dataStorageArray = []
            loadGreta()
        }
    }

    func addRegatta(regatta: Dictionary<String, AnyObject>) {
        dataStorageArray.append(regatta)
        NSUserDefaults.standardUserDefaults().setObject(dataStorageArray, forKey: kArrayKey)
    }

    func updateRegatta(regatta: Dictionary<String, AnyObject>, atIndex:NSInteger) {
        dataStorageArray.removeAtIndex(atIndex)
        dataStorageArray.insert(regatta, atIndex: atIndex)
        NSUserDefaults.standardUserDefaults().setObject(dataStorageArray, forKey: kArrayKey)
    }

    func removeRegattaAtIndex(index: Int) {
        dataStorageArray.removeAtIndex(index)
        NSUserDefaults.standardUserDefaults().setObject(dataStorageArray, forKey: kArrayKey)
    }

    func loadGreta() -> () {
        if let
            path     = NSBundle.mainBundle().pathForResource("sample", ofType: "json"),
            url = NSURL(fileURLWithPath: path),
            data = NSData(contentsOfURL: url),
            array = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [[String: AnyObject]]
            {
                dataStorageArray = array
                NSUserDefaults.standardUserDefaults().setObject(dataStorageArray, forKey: kArrayKey)
            }
        }
}