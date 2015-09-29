//
//  Constants.swift
//  Rang
//
//  Created by Martin Kautz on 21.05.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import UIKit

struct Constants {
    struct Colors {
        static let textColor = UIColor(red: 13/255, green: 63/255, blue: 94/255, alpha: 1)
        static let lightBlue = UIColor(red:0.937255, green:0.937255, blue:0.937255, alpha:1)
    }

    struct Path {
        static let Documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        static let Tmp = NSTemporaryDirectory()
    }
}
