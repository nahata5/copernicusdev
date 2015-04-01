//
//  Medicine.swift
//  Diabetes
//
//  Created by Jeet Patel on 2/19/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit
enum days:String{
    case Monday="Monday",Tuesday="Tuesday",Wednesday="Wednesday",Thursday="Thursday",Friday="Friday",Saturday="Saturday",Sunday="Sunday"
}
var medDays:[days:[Medicine]] = [.Monday:[], .Tuesday:[],.Wednesday:[],.Thursday:[],.Friday:[],.Saturday:[],.Sunday:[]]
var drVisit:[DoctorAppointment] = []
var labVist:[LabVisit] = []
class Medicine:NSObject {
    var dosageTimes:[days:[NSDate]]
    var name:String
    var dosage:Double
    init(name:String, dosage:String, times:[days:[NSDate]]) {
        self.name = name
        self.dosage = NSString(string: dosage).doubleValue
        dosageTimes = times
        super.init()
        for (v,k) in dosageTimes {
            medDays[v]!.append(self)
        }
    }
}
enum DRType:String{
    case Regular = "Regular", Foot = "Foot", Eye = "Eye"
}
class DoctorAppointment:NSObject {
    var doctorName:String
    var date:NSDate
    var type:DRType
    init(date:NSDate, name:String,type:DRType) {
        var s = NSDateFormatter()
        s.dateFormat = "MM/dd/yy hh:mm a"
        self.date = date
        self.type = type
        doctorName = name
        super.init()
    }
}

class LabVisit:NSObject {
    var date:NSDate
    var labName: String
    init(date:NSDate, lab:String) {
        var s = NSDateFormatter()
        s.dateFormat = "MM/dd/yy hh:mm a"
        self.date = date
        labName = lab
    }
}