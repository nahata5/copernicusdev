//
//  vitalsDelegate.swift
//  myCH
//
//  Created by Jeet Patel on 3/15/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit

var temporaryTrackResults = TrackResults()
class vitalsDelegate:NSObject,UITableViewDelegate,UITableViewDataSource {
    var table:UITableView?
    var dismiss = UITapGestureRecognizer()
    var selectedCell:NSIndexPath?
    var bmi = 0
    var bmiCell:NSIndexPath?
    var heightCell:NSIndexPath?
    var weightCell:NSIndexPath?
    var drop = dropDown()
    var rows = 5
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.row{
        /*case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("height") as UITableViewCell
            (cell.viewWithTag(3) as UITextField).addTarget(self, action: "changedHeightWeight:", forControlEvents: .ValueChanged)
            heightCell = indexPath*/
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("weight") as UITableViewCell
            (cell.viewWithTag(3) as UITextField).addTarget(self, action: "changedHeightWeight:", forControlEvents: .ValueChanged)
            weightCell = indexPath
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("bmi") as UITableViewCell
            cell.userInteractionEnabled = false
            bmiCell = indexPath
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("bp") as UITableViewCell
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier("pulse") as UITableViewCell
        case 4:
            cell = tableView.dequeueReusableCellWithIdentifier("mdVisit") as UITableViewCell
        case 5:
            cell = tableView.dequeueReusableCellWithIdentifier("eye") as UITableViewCell
        case 6:
            cell = tableView.dequeueReusableCellWithIdentifier("foot") as UITableViewCell
        default:
            return cell
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.backgroundColor = UIColor.clearColor()
        selectedCell = indexPath
        switch indexPath.row{
        /*case 0:
            showTextField(cell!, _isNumber: true, _isDecimal: true)
            (cell?.viewWithTag(3) as UITextField).addTarget(self, action: "changedHeightWeight:", forControlEvents: .ValueChanged)
            cell?.viewWithTag(3) as UITextField*/
        case 0:
            showTextField(cell!, _isNumber: true, _isDecimal: true)
            (cell?.viewWithTag(3) as UITextField).addTarget(self, action: "changedHeightWeight:", forControlEvents: .ValueChanged)
        case 1:
            showTextField(cell!, _isNumber: true, _isDecimal: false)
        case 2:
            //showTextField(cell!, _isNumber: true, _isDecimal: false)
            drop = dropDown(forCell: cell!, view: tableView.superview!, path: indexPath)
            var label = cell!.viewWithTag(2) as UILabel
            var slash = find(label.text!,"/")!
            var sys = label.text!.substringToIndex(slash).toInt()!
            var tmp = label.text!.substringFromIndex(slash)
            var index = advance(tmp.startIndex, 1)
            var dia = tmp.substringFromIndex(index).toInt()!
            var a = UIPickerView()
            a.delegate = BPPickerDel
            BPPickerDel.label = label
            a.frame = CGRectMake(a.frame.minX, a.frame.minY, drop.frame.width, drop.frame.height)
            a.selectRow(sys-70, inComponent: 0, animated: true)
            a.selectRow(dia-40, inComponent:1, animated: true)
            var b = UILabel()
            b.text = "/"
            drop.addSubview(b)
            drop.bringSubviewToFront(b)
            b.frame = CGRectMake(a.frame.midX, a.frame.midY, b.frame.width, b.frame.height/3)

            drop.addSubview(a)
            drop.present()
        case 3:
            showTextField(cell!, _isNumber: true, _isDecimal: false)
        case 4:
            (cell?.viewWithTag(2) as UISwitch).setOn(!(cell?.viewWithTag(2) as UISwitch).on, animated: true)
        default:
            println()
        }

    }
    
    func changedHeightWeight(sender:AnyObject) {
        var weight = NSString(string: (table!.cellForRowAtIndexPath(weightCell!)?.viewWithTag(3) as UITextField).text).doubleValue
        var bmi = table?.cellForRowAtIndexPath(bmiCell!)?.viewWithTag(2) as UILabel
        var height = currentUser?.height
        var newBmi = (703*weight)/(pow(height!, 2))
        bmi.text = String(format: "%0.1f", newBmi)
        println("Height: \(height) Weight: \(weight) BMI: \(newBmi)")

    }
    
    func showTextField(cell:UITableViewCell, _isNumber: Bool, _isDecimal:Bool) {
        cell.viewWithTag(2)?.hidden = true
        cell.viewWithTag(3)?.hidden = false
        (cell.viewWithTag(3) as UITextField).userInteractionEnabled = true
        (cell.viewWithTag(3) as UITextField).textAlignment = NSTextAlignment.Right
        if _isNumber {
            (cell.viewWithTag(3) as UITextField).keyboardType = UIKeyboardType.NumberPad
            
        }
        
        if _isDecimal {
            (cell.viewWithTag(3) as UITextField).keyboardType = UIKeyboardType.DecimalPad
        }
        (cell.viewWithTag(3) as UITextField).becomeFirstResponder()
        dismiss = UITapGestureRecognizer(target: self, action: "resign")
        table?.superview?.addGestureRecognizer(dismiss)
    }
    
    func resign() {
        var cell = table!.cellForRowAtIndexPath(selectedCell!)!
        table!.superview!.removeGestureRecognizer(dismiss)
        var label = cell.viewWithTag(2) as UILabel
        var field = cell.viewWithTag(3) as UITextField
        field.hidden = true
        label.hidden = false
        field.userInteractionEnabled = false
        if field.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) == "" {
            return
        }
        if cell.reuseIdentifier == "height" {
            label.text = "\(field.text) in"
        } else if cell.reuseIdentifier == "weight"{
            label.text = "\(field.text) lbs"
        } else {
            label.text = field.text
        }

    }
    var constraint = NSLayoutConstraint()
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        table = tableView
        tableView.superview?.addConstraint(constraint)
        tableView.superview?.removeConstraint(constraint)
        constraint = NSLayoutConstraint(item: table!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: CGFloat(44*rows))
        tableView.superview?.addConstraint(constraint)
        return rows
    }
    func callError(cell:UITableViewCell) {
        cell.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
    }
    func submit(vitalsOnly:Bool) -> Bool{
        var submittable = true
        var height:Double = 0
        var weight:Double = 0
        var bp:[Int] = []
        var pulse:Int = 0
        var bmi:Double = 0
        for cells in table!.visibleCells() {
            resign()
            var c = cells as UITableViewCell
            switch c.reuseIdentifier! {
            case "height":
                var label = c.viewWithTag(2) as UILabel
                if label.text == "inches" {
                    submittable = false
                    callError(c)
                } else {
                    var field = c.viewWithTag(3) as UITextField
                    height = NSString(string: field.text).doubleValue
                }
            case "weight":
                var label = c.viewWithTag(2) as UILabel

                if label.text == "lbs" {
                    submittable = false
                    callError(c)
                } else {
                    var field = c.viewWithTag(3) as UITextField
                    weight = NSString(string: field.text).doubleValue
                }
            case "bp":
                var label = c.viewWithTag(2) as UILabel
                var index = find(label.text!, "/")!
                var sys = label.text!.substringToIndex(index).toInt()
                var tmp = label.text!.substringFromIndex(index)
                var newIndex = advance(tmp.startIndex, 1)
                var dia = tmp.substringFromIndex(newIndex).toInt()!
                bp = [sys!,dia]
            case "pulse":
                var label = c.viewWithTag(2) as UILabel
                pulse = label.text!.toInt()!
            case "BMI":
                var label = c.viewWithTag(2) as UILabel
                bmi = NSString(string: label.text!).doubleValue
            default:
                println()
            }
        }
        if submittable {
            if vitalsOnly {
                var s = TrackResults(isDoctor: false, weight: weight, bp: bp, pulse: pulse, bmi: bmi)
                s.addToRecord()
            } else {
                temporaryTrackResults = TrackResults(isDoctor: true, weight: weight, bp: bp, pulse: pulse, bmi: bmi)
            }
        }
        return submittable
    }
}



var BPPickerDel = BPPickerView()
class BPPickerView:NSObject, UIPickerViewDelegate,UIPickerViewDataSource {
    var label:UILabel?
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 110
        } else {
            return 60
        }
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        label?.text = "\(pickerView.selectedRowInComponent(0)+70)/\(pickerView.selectedRowInComponent(1)+40)"
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if component == 0 {
            return String(row+70)
        } else {
            return String(row+40)
        }
    }
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.width/2
    }
}

extension String {
    
    // MARK: - sub String
    func substringToIndex(index:Int) -> String {
        return self.substringToIndex(advance(self.startIndex, index))
    }
    func substringFromIndex(index:Int) -> String {
        return self.substringFromIndex(advance(self.startIndex, index))
    }
    func substringAfterIndex(index:Int) -> String {
        return self.substringFromIndex(advance(self.startIndex, index))
    }
    func substringWithRange(range:Range<Int>) -> String {
        let start = advance(self.startIndex, range.startIndex)
        let end = advance(self.startIndex, range.endIndex)
        return self.substringWithRange(start..<end)
    }
    
    subscript(index:Int) -> Character{
        return self[advance(self.startIndex, index)]
    }
    subscript(range:Range<Int>) -> String {
        let start = advance(self.startIndex, range.startIndex)
        let end = advance(self.startIndex, range.endIndex)
        return self[start..<end]
    }
    
    
    // MARK: - replace
    func replaceCharactersInRange(range:Range<Int>, withString: String!) -> String {
        var result:NSMutableString = NSMutableString(string: self)
        result.replaceCharactersInRange(NSRange(range), withString: withString)
        return result
    }
}
