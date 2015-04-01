//
//  cashoutVC.swift
//  myCH
//
//  Created by Jeet Patel on 3/28/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit

class cashOutVC:UIViewController {
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var cashLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    var points = 500
    var cash = 100
    var number = 0
    var incrementer = NSTimer()
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        incrementer = NSTimer.scheduledTimerWithTimeInterval(0.00000005, target: self, selector: "loop", userInfo: nil, repeats: true)
    }
    func loop() {
            NSThread.sleepForTimeInterval(0.05)
            number+=50
            if number <= points {
                pointsLabel.text = "\(number)"
            }
            if number <= cash {
                cashLabel.text = "$\(number)"
            }
            if max(points, cash) < number {
                incrementer.invalidate()
                UIView.animateWithDuration(0.5, animations: {self.textLabel.alpha = 1})
            }
    }
}