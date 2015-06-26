//
//  InterfaceController.swift
//  Punkte A WatchKit Extension
//
//  Created by Martin Kautz on 26.06.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    //MARK: Properties and constants
    var doneTimer: NSTimer?
    var doneTimer2: NSTimer?
    var duration: NSTimeInterval = 10.0
    var duration2: NSTimeInterval = 7.0

    //MARK: - Outlets
    @IBOutlet weak var runTimer: WKInterfaceTimer!
    @IBOutlet weak var theButton: WKInterfaceButton!

    @IBAction func didTapButton(sender: AnyObject) {
        runTimer.setDate(NSDate(timeIntervalSinceNow: duration))
        runTimer.start()
        doneTimer = NSTimer.scheduledTimerWithTimeInterval(
            duration,
            target: self,
            selector: Selector("timerDone:"),
            userInfo: nil,
            repeats: false)
        doneTimer2 = NSTimer.scheduledTimerWithTimeInterval(
            duration2,
            target: self,
            selector: Selector("timer2Done:"),
            userInfo: nil,
            repeats: false)

        theButton.setTitle("Sync...")
        theButton.setEnabled(false)
    }

    func timerDone(timer: NSTimer) {
        println("Done!")
        theButton.setEnabled(true)
        theButton.setTitle("Start!")
    }

    func timer2Done(timer: NSTimer) {
        println("Beep, beep, beep...")
    }


    //MARK: - Life Cycle
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        theButton.setTitle("Start!")
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