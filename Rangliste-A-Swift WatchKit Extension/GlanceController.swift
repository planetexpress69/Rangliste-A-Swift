//
//  GlanceController.swift
//  Rangliste-A-Swift WatchKit Extension
//
//  Created by Martin Kautz on 05.06.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {

    @IBOutlet weak var labelOne: WKInterfaceLabel?
    @IBOutlet weak var labelTwo: WKInterfaceLabel?

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        labelOne?.setText("Score")
        labelTwo?.setText("89,175")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
