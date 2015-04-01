//
//  drApptForm.swift
//  myCH
//
//  Created by Jeet Patel on 3/13/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit

class DRApptForm:NSObject,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate {
    
    var table:UITableView?
    var selectedIndex:NSIndexPath?
    var dismiss = UITapGestureRecognizer()
    var drop = dropDown()
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("name") as UITableViewCell
            (cell.viewWithTag(3) as UITextField).textAlignment = .Right
            (cell.viewWithTag(3) as UITextField).delegate = self
            (cell.viewWithTag(1) as UILabel).text = "Doctor"
            (cell.viewWithTag(2) as UILabel).text = "Enter Name"
            (cell.viewWithTag(3) as UITextField).userInteractionEnabled = false
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("date") as UITableViewCell
            var s = NSDateFormatter()
            s.dateFormat = "MM/dd/yy hh:mm a"
            (cell.viewWithTag(2) as UILabel).text = s.stringFromDate(NSDate(timeIntervalSinceNow: 0))
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("type") as UITableViewCell
            (cell.viewWithTag(2) as UILabel).text = "Regular"
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("name") as UITableViewCell
            (cell.viewWithTag(2) as UILabel).text = "Regular"
        }
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var c = tableView.cellForRowAtIndexPath(indexPath)!
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch indexPath.row {
        case 0:
            (c.viewWithTag(2) as UILabel).hidden = true
            (c.viewWithTag(3) as UITextField).userInteractionEnabled = true
            (c.viewWithTag(3) as UITextField).hidden = false
            (c.viewWithTag(3) as UITextField).becomeFirstResponder()
            (c.viewWithTag(3) as UITextField).addTarget(self, action: "resign:", forControlEvents: .TouchUpOutside)
            dismiss = UITapGestureRecognizer(target: self, action: "resign:")
            (table!.superview?.superview! as UIScrollView).setContentOffset(CGPoint(x: 0, y: c.frame.maxY), animated: true)
            tableView.superview?.addGestureRecognizer(dismiss)
            selectedIndex = indexPath
        case 1:
            drop = dropDown(forCell: c, view: tableView.superview!, path: indexPath)
            var a = UIDatePicker()
            drop.addSubview(a)
            a.frame = CGRect(x: a.frame.minX, y: a.frame.minY, width: drop.frame.width, height: drop.frame.height)
            var s = NSDateFormatter()
            a.minimumDate = NSDate(timeIntervalSinceNow: 0)
            s.dateFormat = "MM/dd/yy hh:mm a"
            a.setDate(s.dateFromString((c.viewWithTag(2) as UILabel).text!)!, animated: false)
            a.minuteInterval = 30
            a.addTarget(self, action: "DatePickerChanged:", forControlEvents: .ValueChanged)
            drop.present()
        default:
            println()
        }
        c.backgroundColor = UIColor.clearColor()
    }
    func DatePickerChanged(sender:AnyObject) {
        var s = sender as UIDatePicker
        var cell = table!.cellForRowAtIndexPath((s.superview as dropDown).indexPath!)
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy hh:mm a"
        (cell!.viewWithTag(2) as UILabel).text = dateFormatter.stringFromDate(s.date)
    }
    func resign(sender:AnyObject){
        var s = table!.cellForRowAtIndexPath(selectedIndex!)!.viewWithTag(3) as UITextField
        var l = table!.cellForRowAtIndexPath(selectedIndex!)?.viewWithTag(2) as UILabel
        l.hidden = false
        l.text = s.text
        s.hidden=true
        table?.superview?.removeGestureRecognizer(dismiss)
        (table!.superview?.superview! as UIScrollView).setContentOffset(CGPointZero, animated: true)

        s.resignFirstResponder()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        table = tableView
        table?.layer.borderColor = UIColor.lightGrayColor().CGColor
        table?.layer.borderWidth = 0.5
        tableView.superview?.addConstraint(NSLayoutConstraint(item: tableView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 44*2))
        return 2
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if(textField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) != "") {
            (table!.cellForRowAtIndexPath(selectedIndex!)!.viewWithTag(2) as UILabel).text = textField.text
        } else {
            table!.cellForRowAtIndexPath(selectedIndex!)!.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
            table!.cellForRowAtIndexPath(selectedIndex!)!
        }
        (table!.cellForRowAtIndexPath(selectedIndex!)!.viewWithTag(2) as UILabel).hidden = false
        textField.hidden = true
        table?.superview?.removeGestureRecognizer(dismiss)
        (table!.superview?.superview! as UIScrollView).setContentOffset(CGPointZero, animated: true)

        return true
    }
    
    func submit() -> Bool {
        var submittable = true
        var name = ""
        var datess = NSDate(timeIntervalSinceNow: 0)
        var type:DRType = .Regular
        var s = NSDateFormatter()
        for cells in table!.visibleCells() {
            if cells.reuseIdentifier == "name" {
                var lab = cells.viewWithTag(2) as UILabel
                if lab.text == "Enter Name" || lab.text == "" {
                    submittable = false
                    (cells as UITableViewCell).backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                } else {
                    name = lab.text!
                }
            }
            if cells.reuseIdentifier == "date" {
                var date = NSDate(timeIntervalSinceNow: 0)
                s.dateFormat = "MM/dd/yy hh:mm a"
                var label = (cells.viewWithTag(2) as UILabel)
                var dateS = s.dateFromString(label.text!)!
                datess = dateS
            }
            if cells.reuseIdentifier == "type" {
                var lab = cells.viewWithTag(2) as UILabel
                switch lab.text! {
                case "Regular":
                    type = .Regular
                case "Eye":
                    type = .Eye
                case "Foot":
                    type = .Foot
                default:
                    type = .Regular
                }
            }
        }
        if submittable {
            println("Submitting Doctor \(name) for date \(s.stringFromDate(datess))")
            var dr = DoctorAppointment(date: datess, name: name, type: type)
            drVisit.append(dr)
        }
        return submittable
    }
}

