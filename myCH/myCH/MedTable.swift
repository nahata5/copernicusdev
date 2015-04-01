//
//  MedTable.swift
//  Diabetes
//
//  Created by Jeet Patel on 2/19/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit

class MedTable:NSObject,UITableViewDelegate,UITableViewDataSource {
    var today:Int?
    var day:days?
    var information:[Medicine]?
    var isTomorrow = false
    func getDayOfWeek(todayDate:NSDate)->Int{
                var myCalendar:NSCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        var myComponents = myCalendar.components(NSCalendarUnit.WeekdayOrdinalCalendarUnit, fromDate: todayDate)
        var weekDay = myComponents.weekdayOrdinal
        return weekDay
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("medicine") as UITableViewCell
        var name = cell.viewWithTag(1) as UILabel
        var time = cell.viewWithTag(2) as UILabel
        var dose = cell.viewWithTag(3) as UILabel
        var med = information![indexPath.row]
        name.text = "\(med.name)"
        dose.text = "\(med.dosage) tablets"
        var s = NSDateFormatter()
        s.dateFormat = "hh:mm a"
        time.text = s.stringFromDate(findmin(med.dosageTimes[day!]!))
        return cell
    }
    func findmin(s:[NSDate])->NSDate{
        var min = NSDate(timeIntervalSinceNow: 10000000000)
        for dates in s {
            println("\(min) is min and current is \(dates)")
            println("Time Interval: \(min.timeIntervalSinceNow ) - \(dates.timeIntervalSinceNow) = \(min.timeIntervalSinceNow - dates.timeIntervalSinceNow)")
            if(min.timeIntervalSinceDate(NSDate(timeIntervalSinceNow: 0))>dates.timeIntervalSinceDate(NSDate(timeIntervalSinceNow: 0))) {
                min = dates
            }
        }
        return min
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        today = getDayOfWeek(NSDate(timeIntervalSinceNow: 0))
        //Monday is 0
        if isTomorrow {
            today!++
        }
        switch today! {
        case 0:
            information = medDays[.Monday]
            day = .Monday
        case 1:
            information = medDays[.Tuesday]
            day = .Tuesday

        case 2:
            information = medDays[.Wednesday]
            day = .Wednesday

        case 3:
            information = medDays[.Thursday]
            day = .Thursday

        case 4:
            information = medDays[.Friday]
            day = .Friday

        case 5:
            information = medDays[.Saturday]
            day = .Saturday

        case 6:
            information = medDays[.Sunday]
            day = .Sunday


        default:
            println()
        }
        return  information!.count
    }
    
}