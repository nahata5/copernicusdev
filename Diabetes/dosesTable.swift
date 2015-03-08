//
//  dosesTable.swift
//  Diabetes
//
//  Created by Jeet Patel on 3/5/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit

class dosesTable:NSObject,UITableViewDataSource,UITableViewDelegate {
    var rows = 1
    var table:UITableView?
    var s = dpicker()
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        if(rows == 1 || indexPath.row == rows-1) {
            cell = tableView.dequeueReusableCellWithIdentifier("add") as UITableViewCell
            (cell.viewWithTag(2)! as UIButton).userInteractionEnabled = true
            (cell.viewWithTag(2)! as UIButton).addTarget(self, action: "add", forControlEvents: .TouchUpInside)
            cell.selectionStyle = UITableViewCellSelectionStyle.Gray
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier("dose") as UITableViewCell
            cell.selectionStyle = .None
        }
        return cell
    }
    func add() {
        rows++
        table!.reloadData()
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if rows == 1 || indexPath.row == rows-1 {
            return false
        } else {
            return true
        }
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.Delete) {
            rows--
            table?.reloadData()
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(rows == 1 || indexPath.row == rows - 1) {
            add()
        } else {
            s.cellRow = indexPath.row
            s.cell = tableView.cellForRowAtIndexPath(indexPath)!
            var text=s.cell?.viewWithTag(10) as UILabel
            if (text.text != "Set Time"){
                s.present(tableView.superview!, withDate: text.text!)
            } else {
                s.present(tableView.superview!)
            }
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setTime:", name: "PickerDidReturnDate", object: nil)
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "TableDidAddRow", object: self, userInfo: ["rows":rows,"height":tableView.rowHeight]))
        return rows
    }
    func setTime(notif:NSNotification){
        var info = notif.userInfo! as [String:AnyObject]
        var label = s.cell!.viewWithTag(10) as UILabel
        var e = NSDateFormatter()
        e.dateFormat = "hh:mm"
        label.text = e.stringFromDate(info["date"] as NSDate)
        
    }
}
