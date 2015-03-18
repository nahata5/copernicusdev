//
//  labForm.swift
//  myCH
//
//  Created by Jeet Patel on 3/13/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit

class labEdit:NSObject,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate {
    //Name
    //Date
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
            (cell.viewWithTag(2) as UILabel).text = "Enter Name"
            (cell.viewWithTag(3) as UITextField).userInteractionEnabled = false
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("date") as UITableViewCell
            var s = NSDateFormatter()
            s.dateFormat = "MM/dd/yy hh:mm a"
            (cell.viewWithTag(2) as UILabel).text = s.stringFromDate(NSDate(timeIntervalSinceNow: 0))
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("name") as UITableViewCell
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
            tableView.superview?.addGestureRecognizer(dismiss)
            println(tableView.superview!.superview!)
            (tableView.superview!.superview! as UIScrollView).setContentOffset(CGPoint(x: 0, y: c.frame.maxY), animated: true)
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
        (table!.superview?.superview! as UIScrollView).setContentOffset(CGPointZero, animated: true)
        l.hidden = false
        l.text = s.text
        s.hidden=true
        table?.superview?.removeGestureRecognizer(dismiss)
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
        var datess = NSDate()
        var name = ""
        for cells in table!.visibleCells() {
            if cells.reuseIdentifier == "name" {
                var lab = cells.viewWithTag(2) as UILabel
                if lab.text == "Enter Name" || lab.text == "" {
                    submittable = false
                    (cells as UITableViewCell).backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                }
                name = lab.text!
            }
            if cells.reuseIdentifier == "date" {
                var date = NSDate(timeIntervalSinceNow: 0)
                var s = NSDateFormatter()
                s.dateFormat = "MM/dd/yy hh:mm a"
                var dateS = s.dateFromString((cells.viewWithTag(2) as UILabel).text!)!
                datess = dateS
                if date.timeIntervalSinceDate(dateS) < 0{
                    submittable = false
                }
            }
        }
        if submittable {
            var lab = LabVisit(date: datess, lab: name)
            labVist.append(lab)
        }
        return submittable
    }
    
}
