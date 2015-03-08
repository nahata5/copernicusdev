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
    var medArray:[Medicine] = []
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("medicine") as UITableViewCell
        var image = cell.viewWithTag(100) as UIImageView
        var eWidth = NSLayoutConstraint(item: image, attribute: .Width, relatedBy: .Equal, toItem: cell, attribute: .Width, multiplier: 0.2, constant: 0)
        cell.addConstraint(eWidth)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  medArray.count
    }
    
}