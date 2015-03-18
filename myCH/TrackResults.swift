//
//  Results.swift
//  myCH
//
//  Created by Jeet Patel on 3/15/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit
var results:[NSDate:TrackResults] = [:]
class TrackResults:NSObject {
    var dateMeasured:NSDate
    var doctorVerified:Bool
    var weight:Double
    var bp:[Int]
    var pulse:Int
    var bmi:Double
    var HBA1C:Double?
    var HDL:Double?
    var LDL:Double?
    var TAG:Double?
    var cholesterol:Double?
    func registerLabs(hba1c:Double, hdl:Double, ldl:Double, tag:Double, chol:Double) {
        HBA1C = hba1c
        HDL = hdl
        TAG = tag
        LDL = ldl
        cholesterol = chol
        doctorVerified = true
    }
    func addToRecord() {
        results[dateMeasured] = self
    }
    
    override init() {
        self.weight = 0
        self.bp = [0]
        self.pulse = 0
        self.bmi = 0
        dateMeasured = NSDate(timeIntervalSinceNow: 0)
        self.doctorVerified = false
        super.init()
    }
    init(isDoctor:Bool, weight:Double, bp:[Int], pulse:Int, bmi:Double) {
        doctorVerified = isDoctor
        self.weight = weight
        self.bp = bp
        self.pulse = pulse
        self.bmi = bmi
        dateMeasured = NSDate(timeIntervalSinceNow: 0)
        super.init()
    }
    init(isDoctor:Bool, weight:Double, bp:[Int], pulse:Int, bmi:Double, hba1c:Double, hdl:Double, tag:Double, chol:Double) {
        doctorVerified = true
        self.weight = weight
        self.bp = bp
        self.pulse = pulse
        self.bmi = bmi
        dateMeasured = NSDate(timeIntervalSinceNow: 0)
        self.cholesterol = chol
        super.init()
        results[self.dateMeasured] = self
    }

}