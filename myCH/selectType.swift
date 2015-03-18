//
//  selectType.swift
//  myCH
//
//  Created by Jeet Patel on 3/13/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit

class scheduleAppt:NSObject,UITableViewDelegate,UITableViewDataSource {
    
    //Name
    //Date
    var table:UITableView?
    var selects = ""
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("medicine") as UITableViewCell
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("doctor") as UITableViewCell
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("lab") as UITableViewCell
        default:
            return cell
        }
        cell.selectionStyle = .None
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var index = ""
        var cell = tableView.cellForRowAtIndexPath(indexPath)!
        switch indexPath.row {
        case 0:
            index = "0"
            for cells in tableView.visibleCells() as [UITableViewCell] {
                cells.accessoryType = UITableViewCellAccessoryType.None
            }
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            selects = "Medicine"
        case 1:
            index = "1"
            for cells in tableView.visibleCells() as [UITableViewCell] {
                cells.accessoryType = UITableViewCellAccessoryType.None
            }
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            selects = "Doctor"
        case 2:
            index = "2"
            for cells in tableView.visibleCells() as [UITableViewCell] {
                cells.accessoryType = UITableViewCellAccessoryType.None
            }
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            selects = "Lab"
        default:
            print()
        }
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: userChoseScheduleType, object: nil, userInfo: ["selected":index]))
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.superview?.addConstraint(NSLayoutConstraint(item: tableView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 44*3))
        table = tableView
        table?.layer.borderColor = UIColor.lightGrayColor().CGColor
        table?.layer.borderWidth = 0.5
        return 3
    }
    
    func submit() {
        
    }
}