//
//  LabDelegate.swift
//  myCH
//
//  Created by Jeet Patel on 3/15/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit

class LabDelegate:NSObject,UITableViewDelegate,UITableViewDataSource {
    var table:UITableView?
    var dismiss = UITapGestureRecognizer()
    var selectedCell:NSIndexPath?
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("hba1c") as UITableViewCell
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("hdl") as UITableViewCell
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("ldl") as UITableViewCell
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier("tag") as UITableViewCell
        case 4:
            cell = tableView.dequeueReusableCellWithIdentifier("cholesterol") as UITableViewCell
        default:
            cell = UITableViewCell()
        }
        var field = cell.viewWithTag(3) as UITextField
        field.userInteractionEnabled = false
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        cell?.backgroundColor = UIColor.clearColor()
        selectedCell = indexPath
        switch indexPath.row {
        case 0:
            showTextField(cell!, _isNumber: true, _isDecimal: true)
        case 1:
            showTextField(cell!, _isNumber: true, _isDecimal: true)
        case 2:
            showTextField(cell!, _isNumber: true, _isDecimal: true)
        case 3:
            showTextField(cell!, _isNumber: true, _isDecimal: true)
        case 4:
            showTextField(cell!, _isNumber: true, _isDecimal: true)
        default:
            println()
        }
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
    func submit() -> Bool {
        var cells = table!.visibleCells() as [UITableViewCell]
        resign()
        var submittable = true
        var hba1c = 0.00
        var hdl = 0.00
        var ldl = 0.00
        var tag = 0.00
        var cholesterol = 0.00
        for cell in cells {
            var label = cell.viewWithTag(2) as UILabel
            switch cell.reuseIdentifier! {
            case "hba1c":
                if label.text == "Enter Amount" || label.text == "" {
                    submittable = false
                    cell.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                } else {
                    var num = NSString(string: label.text!).doubleValue
                    hba1c = num
                }
            case "hdl":
                if label.text == "Enter Amount" || label.text == "" {
                    submittable = false
                    cell.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                } else {
                    var num = NSString(string: label.text!).doubleValue
                    hdl = num
                }
            case "ldl":
                if label.text == "Enter Amount" || label.text == "" {
                    submittable = false
                    cell.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)

                } else {
                    var num = NSString(string: label.text!).doubleValue
                    ldl = num
                }
            case "tag":
                if label.text == "Enter Amount" || label.text == "" {
                    submittable = false
                    cell.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                } else {
                    var num = NSString(string: label.text!).doubleValue
                    tag = num
                }
            case "cholesterol":
                if label.text == "Enter Amount" || label.text == "" {
                    submittable = false
                    cell.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                } else {
                    var num = NSString(string: label.text!).doubleValue
                    cholesterol = num
                }
            default:
                println()
            }
        }
        if submittable {
            temporaryTrackResults.registerLabs(hba1c, hdl: hdl, ldl: ldl, tag: tag, chol: cholesterol)
        }
        return submittable
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        table = tableView
        tableView.superview?.addConstraint(NSLayoutConstraint(item: table!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 44*5))
        return 5
    }
}