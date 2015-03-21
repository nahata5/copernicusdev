//
//  Question.swift
//  Diabetes
//
//  Created by Jeet Patel on 3/7/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit
class questionView:NSObject, UITableViewDelegate,UITableViewDataSource {
    var table:UITableView?
    var question:String?
    var option:[String] = []
    var correctIndex = -1
    var rows = 0
    var isSetup = false
    var letters = ["A","B","C","D","E","F"]
    var selectedRow:NSIndexPath?
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.userInteractionEnabled = true
        if !isSetup {
            return 0
        }
        rows = option.count + 1
        return rows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("question") as UITableViewCell
            var label = cell.viewWithTag(1) as UILabel
            label.textAlignment = .Center
            label.numberOfLines = 0
            label.text! = question!
            cell.selectionStyle = .None
            cell.userInteractionEnabled  = false
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("option") as UITableViewCell
            var letter = cell.viewWithTag(1) as UILabel
            var options = cell.viewWithTag(2) as UILabel
            letter.text = letters[indexPath.row-1]
            letter.sizeToFit()
            options.text = option[indexPath.row-1]
            options.lineBreakMode = NSLineBreakMode.ByWordWrapping
            options.numberOfLines = 0
            options.sizeToFit()
            letter.backgroundColor = UIColor(red: 35/255, green: 136/255, blue: 219/255, alpha: 1)
            letter.textColor = UIColor.whiteColor()
            cell.addConstraint(NSLayoutConstraint(item: letter, attribute: .Width, relatedBy: .Equal, toItem: letter.superview, attribute: .Width, multiplier: 0.1, constant: 0))
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRow = indexPath
        if indexPath.row != 0 {
            for cells in tableView.visibleCells() as [UITableViewCell] {
                if cells.reuseIdentifier == "option" {
                    (cells.viewWithTag(1) as UILabel).backgroundColor = UIColor(red: 35/255, green: 136/255, blue: 219/255, alpha: 1)
                    (cells.viewWithTag(1) as UILabel).textColor = UIColor.whiteColor()
                    (cells.viewWithTag(2) as UILabel!).textColor = .blackColor()
                }
            }
            (tableView.cellForRowAtIndexPath(indexPath)?.viewWithTag(1) as UILabel!).backgroundColor = UIColor.whiteColor()
            (tableView.cellForRowAtIndexPath(indexPath)?.viewWithTag(2) as UILabel!).textColor = UIColor(red: 35/255, green: 136/255, blue: 219/255, alpha: 1)
            (tableView.cellForRowAtIndexPath(indexPath)?.viewWithTag(1) as UILabel!).textColor = UIColor(red: 35/255, green: 136/255, blue: 219/255, alpha: 1)

        }
    }
    func submit() {
        println(selectedRow)
        if selectedRow != nil {
            var selectedCell = table!.cellForRowAtIndexPath(selectedRow!)! as UITableViewCell
            println(selectedRow?.row)
            var letter = selectedCell.viewWithTag(1) as UILabel
            var op = selectedCell.viewWithTag(2) as UILabel
            if selectedRow!.row == correctIndex {
                //(selectedCell.viewWithTag(1) as UILabel).text = "✅"
                //(selectedCell.viewWithTag(2) as UILabel!).textColor = .greenColor()
                letter.backgroundColor = .greenColor()
                letter.textColor = .whiteColor()
            } else {
                //(selectedCell.viewWithTag(1) as UILabel).text = "❌"
                //(selectedCell.viewWithTag(2) as UILabel!).textColor = .redColor()
                letter.backgroundColor = .redColor()
                letter.textColor = .whiteColor()
                (table!.cellForRowAtIndexPath(NSIndexPath(forRow: correctIndex, inSection: 0))?.viewWithTag(1) as UILabel).textColor = .whiteColor()
                (table!.cellForRowAtIndexPath(NSIndexPath(forRow: correctIndex, inSection: 0))?.viewWithTag(1) as UILabel).backgroundColor = .greenColor()
                //(table!.cellForRowAtIndexPath(NSIndexPath(forRow: correctIndex, inSection: 0))?.viewWithTag(1) as UILabel).text = "✅"
                //(table!.cellForRowAtIndexPath(NSIndexPath(forRow: correctIndex, inSection: 0))!.viewWithTag(2) as UILabel!).textColor = .greenColor()
            }
                table?.userInteractionEnabled = false
        }
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        tableView.contentInset = UIEdgeInsetsZero
        return 0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (tableView.frame.height)/CGFloat(rows)
    }
    func askQuestion(tableView:UITableView, question:String, options:[String], correctIndex:Int) {
        table = tableView
        self.question = question
        self.option = options
        self.correctIndex = correctIndex + 1
        isSetup = true
        table?.reloadData()
    }
}

//
//  Question.swift
//  Diabetes
//
//  Created by Jeet Patel on 3/7/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit
class txtQuestionView:NSObject, UITableViewDelegate,UITableViewDataSource {
    var table:UITableView?
    var question:String?
    var option:[String] = []
    var correctIndex = -1
    var rows = 0
    var isSetup = false
    var letters = ["A","B","C","D","E","F"]
    var selectedRow:NSIndexPath?
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.userInteractionEnabled = true
        if !isSetup {
            return 0
        }
        rows = option.count + 1
        return rows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("question") as UITableViewCell
            var label = cell.viewWithTag(1) as UILabel
            label.textAlignment = .Center
            label.numberOfLines = 0
            label.text! = question!
            cell.selectionStyle = .None
            cell.userInteractionEnabled  = false
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("option") as UITableViewCell
            var letter = cell.viewWithTag(1) as UILabel
            var options = cell.viewWithTag(2) as UILabel
            letter.text = letters[indexPath.row-1]
            letter.sizeToFit()
            options.text = option[indexPath.row-1]
            options.lineBreakMode = NSLineBreakMode.ByWordWrapping
            options.numberOfLines = 0
            options.sizeToFit()
            letter.backgroundColor = UIColor(red: 35/255, green: 136/255, blue: 219/255, alpha: 1)
            letter.textColor = UIColor.whiteColor()
            cell.addConstraint(NSLayoutConstraint(item: letter, attribute: .Width, relatedBy: .Equal, toItem: letter.superview, attribute: .Width, multiplier: 0.1, constant: 0))
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRow = indexPath
        if indexPath.row != 0 {
            for cells in tableView.visibleCells() as [UITableViewCell] {
                if cells.reuseIdentifier == "option" {
                    (cells.viewWithTag(1) as UILabel).backgroundColor = UIColor(red: 35/255, green: 136/255, blue: 219/255, alpha: 1)
                    (cells.viewWithTag(1) as UILabel).textColor = UIColor.whiteColor()
                    (cells.viewWithTag(2) as UILabel!).textColor = .blackColor()
                }
            }
            (tableView.cellForRowAtIndexPath(indexPath)?.viewWithTag(1) as UILabel!).backgroundColor = UIColor.whiteColor()
            (tableView.cellForRowAtIndexPath(indexPath)?.viewWithTag(2) as UILabel!).textColor = UIColor(red: 35/255, green: 136/255, blue: 219/255, alpha: 1)
            (tableView.cellForRowAtIndexPath(indexPath)?.viewWithTag(1) as UILabel!).textColor = UIColor(red: 35/255, green: 136/255, blue: 219/255, alpha: 1)
            
        }
    }
    func submit() {
        println(selectedRow)
        if selectedRow != nil {
            var selectedCell = table!.cellForRowAtIndexPath(selectedRow!)! as UITableViewCell
            println(selectedRow?.row)
            var letter = selectedCell.viewWithTag(1) as UILabel
            var op = selectedCell.viewWithTag(2) as UILabel
            if selectedRow!.row == correctIndex {
                //(selectedCell.viewWithTag(1) as UILabel).text = "✅"
                //(selectedCell.viewWithTag(2) as UILabel!).textColor = .greenColor()
                letter.backgroundColor = .greenColor()
                letter.textColor = .whiteColor()
            } else {
                //(selectedCell.viewWithTag(1) as UILabel).text = "❌"
                //(selectedCell.viewWithTag(2) as UILabel!).textColor = .redColor()
                letter.backgroundColor = .redColor()
                letter.textColor = .whiteColor()
                (table!.cellForRowAtIndexPath(NSIndexPath(forRow: correctIndex, inSection: 0))?.viewWithTag(1) as UILabel).textColor = .whiteColor()
                (table!.cellForRowAtIndexPath(NSIndexPath(forRow: correctIndex, inSection: 0))?.viewWithTag(1) as UILabel).backgroundColor = .greenColor()
                //(table!.cellForRowAtIndexPath(NSIndexPath(forRow: correctIndex, inSection: 0))?.viewWithTag(1) as UILabel).text = "✅"
                //(table!.cellForRowAtIndexPath(NSIndexPath(forRow: correctIndex, inSection: 0))!.viewWithTag(2) as UILabel!).textColor = .greenColor()
            }
            table?.userInteractionEnabled = false
        }
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        tableView.contentInset = UIEdgeInsetsZero
        return 0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (tableView.frame.height)/CGFloat(rows)
    }
    func askQuestion(tableView:UITableView, question:String, options:[String], correctIndex:Int) {
        table = tableView
        self.question = question
        self.option = options
        self.correctIndex = correctIndex + 1
        isSetup = true
        table?.reloadData()
    }
}







