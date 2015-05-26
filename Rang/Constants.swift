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
        static let darkBlue = UIColor(red: 20/255, green: 50/255, blue: 150/255, alpha: 1)
    }

    struct Path {
        static let Documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        static let Tmp = NSTemporaryDirectory()
    }
}
