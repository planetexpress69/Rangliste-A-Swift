//
//  SimpleDataProvider.swift
//  Rang
//
//  Created by Martin Kautz on 21.05.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import Foundation

class SimpleDataProvider {

    var kArrayKey = "storedDataArray"

    var dataStorageArray: Array<Dictionary<String, AnyObject>>

    class var sharedInstance: SimpleDataProvider {
        struct Static {
            //static var onceToken: dispatch_once_t = 0
            static var instance: SimpleDataProvider? = nil
        }
        //dispatch_once(&Static.onceToken) {
            Static.instance = SimpleDataProvider()
        //}
        return Static.instance!
    }

    init() {
        var userdefaults = NSUserDefaults.standardUserDefaults()
        if ((userdefaults.objectForKey(kArrayKey)) != nil) {
            dataStorageArray = userdefaults.objectForKey(kArrayKey) as! Array
        } else {
            dataStorageArray = []
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
}