//
//  dosesTable.swift
//  Diabetes
//
//  Created by Jeet Patel on 3/5/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit
var pickerDel = dosage()
var freqPickerDel = freq()
var numPickerDel = freqnumber()
var rows = 4

class dosesTable:NSObject,UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate {
    var table:UITableView?
    var selectedIndex:NSIndexPath = NSIndexPath()
    var dropDownView = dropDown()
    var dismiss = UITapGestureRecognizer()
    var height:NSLayoutConstraint?
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        switch indexPath.row {
        case 0:
                cell = tableView.dequeueReusableCellWithIdentifier("name") as UITableViewCell
                cell.viewWithTag(3)?.hidden = true
        case 1:
                cell = tableView.dequeueReusableCellWithIdentifier("dosage") as UITableViewCell
        case 2:
                cell = tableView.dequeueReusableCellWithIdentifier("frequency") as UITableViewCell
        case 3:
                cell = tableView.dequeueReusableCellWithIdentifier("time") as UITableViewCell
        default:
                cell = tableView.dequeueReusableCellWithIdentifier("time") as UITableViewCell
        }
        return cell
    }
    
    
    func add() {
        rows++
        table!.reloadData()
    }
    func setInfo(usingMed:Medicine) {
        
    }

    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
   
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        cell.backgroundColor = UIColor.whiteColor()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        selectedIndex = indexPath
        switch indexPath.row {
        case 0:
            var field = cell.viewWithTag(3)! as UITextField
            field.textAlignment = .Right
            field.returnKeyType = UIReturnKeyType.Next
            field.delegate=self
            field.autocorrectionType = UITextAutocorrectionType.No
            dismiss = UITapGestureRecognizer(target: self, action: "resign:")
            tableView.superview?.addGestureRecognizer(dismiss)
            var detail = cell.viewWithTag(2)! as UILabel
            field.hidden = false
            detail.hidden = true
            field.becomeFirstResponder()
            (table!.superview?.superview! as UIScrollView).setContentOffset(CGPoint(x: 0, y: cell.frame.maxY), animated: true)
        case 1:
            var cell = tableView.cellForRowAtIndexPath(indexPath)!
            var label = cell.viewWithTag(2) as UILabel
            dropDownView = dropDown(forCell: cell, view: tableView.superview!, path: indexPath)
            dropDownView.present()
            var a = UIPickerView()
            a.dataSource = pickerDel
            a.delegate = pickerDel
            if pickerDel.selected != -1 {
                a.selectRow(pickerDel.selected, inComponent: 0, animated: true)
            } else {
                a.selectRow(0, inComponent: 0, animated: true)
            }
            dropDownView.addSubview(a)
            a.frame = CGRect(x: a.frame.minX, y: a.frame.minY, width: dropDownView.frame.width, height: dropDownView.frame.height)
        case 2:
            var cell = tableView.cellForRowAtIndexPath(indexPath)!
            dropDownView = dropDown(forCell: cell, view: tableView.superview!, path: indexPath)
            dropDownView.present()
            var a = UIPickerView()
            a.tag = 1
            var b = UIPickerView()
            b.tag = 2
            a.dataSource = numPickerDel
            a.delegate = numPickerDel
            b.dataSource = freqPickerDel
            b.delegate = freqPickerDel
            if numPickerDel.selected != -1 {
                a.selectRow(numPickerDel.selected, inComponent: 0, animated: true)
            } else {
                a.selectRow(0, inComponent: 0, animated: true)
            }
            if numPickerDel.selected != -1 {
                b.selectRow(freqPickerDel.selected, inComponent: 0, animated: true)
                
            } else {
                b.selectRow(0, inComponent: 0, animated: true)
            }
            dropDownView.addSubview(a)
            dropDownView.addSubview(b)
            a.frame = CGRect(x: a.frame.minX, y: a.frame.minY, width: dropDownView.frame.width/4, height: dropDownView.frame.height)
            b.frame = CGRect(x: a.frame.maxX, y: a.frame.minY, width: (3/4)*dropDownView.frame.width, height: dropDownView.frame.height)
        default:
            var cell = tableView.cellForRowAtIndexPath(indexPath)!
            dropDownView = dropDown(forCell: cell, view: tableView.superview!, path: indexPath)
            dropDownView.present()
            var a = UIDatePicker(frame: CGRectZero)
            a.datePickerMode = .Time
            a.addTarget(self, action: "change:", forControlEvents: .ValueChanged)
            a.frame = CGRect(x: a.frame.minX, y: a.frame.minY, width: dropDownView.frame.width, height: dropDownView.frame.height)
            var s = NSDateFormatter()
            s.dateFormat = "hh:mm a"
            a.setDate(s.dateFromString("12:00 AM")!, animated: true)
            if((table?.cellForRowAtIndexPath(indexPath)?.viewWithTag(2) as UILabel).text != "12:00 AM") {
                a.setDate(s.dateFromString((table?.cellForRowAtIndexPath(indexPath)?.viewWithTag(2) as UILabel).text!)!, animated: true)
            }
            a.minuteInterval = 15
            dropDownView.addSubview(a)
            if(dropDownView.frame.maxY > table!.superview!.frame.height-CGFloat(100.0)){
                (table!.superview!.superview! as UIScrollView).setContentOffset(CGPoint(x: 0, y: dropDownView.frame.minY - CGFloat(rows)), animated: true)
            }
        }
    }
    func change(sender:AnyObject){
        var s = sender as UIDatePicker
        var f = NSDateFormatter()
        f.dateFormat = "hh:mm a"
        var date = f.stringFromDate(s.date)
        var drop = sender.superview as dropDown
        (table?.cellForRowAtIndexPath(drop.indexPath!)?.viewWithTag(2)! as UILabel).text = date
    }
    func resign(sender:AnyObject){
            var s = table!.cellForRowAtIndexPath(selectedIndex)!.viewWithTag(3) as UITextField
            var l = table!.cellForRowAtIndexPath(selectedIndex)?.viewWithTag(2) as UILabel
            l.hidden = false
            l.text = s.text
            s.hidden=true
            table?.superview?.removeGestureRecognizer(dismiss)
            s.resignFirstResponder()
        (table!.superview?.superview! as UIScrollView).setContentOffset(CGPointZero, animated: true)

    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        table = tableView
        table?.layer.borderColor = UIColor.lightGrayColor().CGColor
        table?.layer.borderWidth = 0.5
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "dosageChosen:", name: "PickerMovedDosage", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "freqNumChosen:", name: "PickerMovedFreqNum", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "freqChosen:", name: "PickerMovedFreqDayWeek", object: nil)
        if height != nil {
            tableView.superview!.removeConstraint(height!)
            height = NSLayoutConstraint(item: tableView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: CGFloat(44*rows))
            tableView.superview!.addConstraint(height!)
        } else {
            height = NSLayoutConstraint(item: tableView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: CGFloat(44*rows))
            tableView.superview!.addConstraint(height!)
        }
        return rows
    }
    
    func dosageChosen(notif:NSNotification) {
        var s = notif.userInfo! as [String:AnyObject]
        var t = notif.object as dropDown
        var l = table!.cellForRowAtIndexPath(t.indexPath!)?.viewWithTag(2)! as UILabel
        var z = (s["title"] as Double)
        l.text = String(format: "%0.1f", z)
    }
    
    func submit() -> Bool {
        var a = table?.visibleCells() as [UITableViewCell]
        var submittable = true
        var name = ""
        var dosage = ""
        var dosefrequency = 1
        var times:[NSDate] = []
        var dosageTimes:[days:[NSDate]] = [.Monday:[],.Tuesday:[],.Wednesday:[],.Thursday:[],.Friday:[],.Saturday:[],.Sunday:[]]
        for cells in a {
            switch cells.reuseIdentifier! {
                case "name":
                    var l = cells.viewWithTag(2)! as UILabel
                    if    l.text!.stringByTrimmingCharactersInSet(.whitespaceCharacterSet()) == "" || l.text! == "Medication"{
                        cells.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                        submittable = false
                    }
                    name = l.text!
                case "dosage":
                    var l = cells.viewWithTag(2)! as UILabel
                    if    l.text!.stringByTrimmingCharactersInSet(.whitespaceCharacterSet()) == "" || l.text == "# of Pills" {
                        cells.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                        submittable = false
                    }
                    dosage = l.text!
                case "freq":
                    var l = cells.viewWithTag(2)! as UILabel
                    if    l.text!.stringByTrimmingCharactersInSet(.whitespaceCharacterSet()) == ""{
                        cells.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                        submittable = false
                    }
                    var freq = freqPickerDel.s[freqPickerDel.selected]
                    if(freq == "Weekly"){
                        dosefrequency = -1
                    } else {
                        dosefrequency = numPickerDel.s[numPickerDel.selected]
                    }
                case "time":
                    var l = cells.viewWithTag(2)! as UILabel
                    if    l.text!.stringByTrimmingCharactersInSet(.whitespaceCharacterSet()) == "" || l.text! == "HH:MM"{
                        cells.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                        submittable = false
                    }
                    var s = NSDateFormatter()
                    s.dateFormat = "hh:mm a"
                    times.append(s.dateFromString(l.text!)!)
                default:
                    print()
            }
        }
        if submittable {
            var s = Medicine(name: name, dosage: dosage, times: dosageTimes)
            println("Submittable Medicine: \(name), \(dosage) tablets, \(dosefrequency) times daily, and \(times)")
            if dosefrequency == -1 {
            
            } else {
                for (v,k) in dosageTimes {
                    for time in times {
                         dosageTimes[v]!.append(time)
                    }
                    if(k.count != 0) {
                        medDays[v]!.append(s)
                    }
                }
            }
            s.dosageTimes = dosageTimes
            return true
        } else {
            return false
        }
    }
    
    func freqNumChosen(notif:NSNotification) {
        var s = notif.userInfo! as [String:AnyObject]
        var t = notif.object as dropDown
        var l = table!.cellForRowAtIndexPath(t.indexPath!)?.viewWithTag(2)! as UILabel
        var num = String(s["title"] as Int)
        var p2 = t.viewWithTag(2) as UIPickerView
        var fre = freqPickerDel.s[p2.selectedRowInComponent(0)]
        switch num {
        case "1":
            l.text = "Once \(fre.lowercaseString)"
        case "2":
            l.text = "Twice \(fre.lowercaseString)"
        default:
            l.text = "\(num) times \(fre.lowercaseString)"
        }
        rows = 3 + num.toInt()!
        table?.reloadData()
    }
    func freqChosen(notif:NSNotification) {
        var s = notif.userInfo! as [String:AnyObject]
        var t = notif.object as dropDown
        
        var l = table!.cellForRowAtIndexPath(t.indexPath!)?.viewWithTag(2)! as UILabel
        
        var p2 = t.viewWithTag(1) as UIPickerView
        var num = numPickerDel.s[p2.selectedRowInComponent(0)]
        var fre = String(s["title"] as String)
        switch num {
        case 1:
            l.text = "Once \(fre.lowercaseString)"
        case 2:
            l.text = "Twice \(fre.lowercaseString)"
        default:
            l.text = "\(num) times \(fre.lowercaseString)"
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if(textField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) != "") {
            (table!.cellForRowAtIndexPath(selectedIndex)!.viewWithTag(2) as UILabel).text = textField.text
        } else {
            table!.cellForRowAtIndexPath(selectedIndex)!.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
            table!.cellForRowAtIndexPath(selectedIndex)!
        }
        (table!.cellForRowAtIndexPath(selectedIndex)!.viewWithTag(2) as UILabel).hidden = false
        textField.hidden = true
        table?.superview?.removeGestureRecognizer(dismiss)
        (table!.superview?.superview! as UIScrollView).setContentOffset(CGPointZero, animated: true)
        return true
    }
    
}

class freqnumber:NSObject,UIPickerViewDataSource,UIPickerViewDelegate {
    var s:[Int] = []
    var selected:Int = 0
    var selectedTitle = ""
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        for index in 1...10 {
            s.append(index)
        }
        return 10
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(s[row])"
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = row
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "PickerMovedFreqNum", object: pickerView.superview, userInfo: ["title":s[row]]))
    }

}
class dosage:NSObject,UIPickerViewDataSource,UIPickerViewDelegate {
    var s:[Double] = [0.5]
    var selected:Int = 0
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        for index in 1...10 {
            s.append(Double(index))
        }
        return 11
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(s[row])"
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = row
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "PickerMovedDosage", object: pickerView.superview, userInfo: ["title":s[row]]))
    }
    
}
class freq:NSObject,UIPickerViewDataSource,UIPickerViewDelegate {
    var s:[String] = ["Daily", "Weekly"]
    var selected:Int = 0
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(s[row])"
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = row
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "PickerMovedFreqDayWeek", object: pickerView.superview, userInfo: ["title":s[row]]))
    }
    
}

