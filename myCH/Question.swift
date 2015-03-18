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
            options.sizeThatFits(CGSize(width: cell.frame.width, height: cell.frame.height))
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
        if selectedRow != nil {
            var selectedCell = table!.cellForRowAtIndexPath(selectedRow!)! as UITableViewCell
            if selectedRow!.row == correctIndex {
                (selectedCell.viewWithTag(1) as UILabel).text = "✅"
                (selectedCell.viewWithTag(2) as UILabel!).textColor = .greenColor()
            } else {
                (selectedCell.viewWithTag(1) as UILabel).text = "❌"
                (selectedCell.viewWithTag(2) as UILabel!).textColor = .redColor()
                (table!.cellForRowAtIndexPath(NSIndexPath(forRow: correctIndex, inSection: 0))?.viewWithTag(1) as UILabel).text = "✅"
                (table!.cellForRowAtIndexPath(NSIndexPath(forRow: correctIndex, inSection: 0))!.viewWithTag(2) as UILabel!).textColor = .greenColor()
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




/*
class QuestionView:UIView {
    var numberOfOptions:Int
    var options:[MCOption]
    var correctAnswerIndex = -1
    var label = UILabel(frame: CGRectZero)

    init(question:String, options:Int, text:[String], correctIndex:Int,superr:UIView) {
        numberOfOptions = options
        self.options = []
        super.init(frame:CGRectZero)
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
    }
    func setupOptions(numberOfOptions:Int, text:[String], correctIndex:Int) {
        for(var i=0; i<numberOfOptions; i++) {
            var correct = correctIndex == i
            var opt = MCOption(text: text[i],Correct: correct,superr: self)
            self.options.append(opt)
            self.addSubview(opt)
            opt.setTranslatesAutoresizingMaskIntoConstraints(false)
            if(i==0) {
                self.addConstraints([NSLayoutConstraint(item: opt, attribute: .Top, relatedBy: .Equal, toItem: label, attribute: .Bottom, multiplier: 1, constant: 10),
                    ])
            } else {
                self.addConstraints([NSLayoutConstraint(item: opt, attribute: .Top, relatedBy: .Equal, toItem: self.options[i-1], attribute: .Bottom, multiplier: 1, constant:10)])
            }
            self.addConstraints([NSLayoutConstraint(item: opt, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier:1, constant: 0), NSLayoutConstraint(item: opt, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: 0),NSLayoutConstraint(item: opt, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0.15, constant: 0)])
        }
    }
    func setTitle(string:String) {
        label.text = string
    }
    
    required init(coder aDecoder: NSCoder) {
        numberOfOptions = 5
        self.options = []
        super.init(frame:CGRectZero)
        self.backgroundColor = UIColor.clearColor()
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(label)
        label.textAlignment = .Center
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        addConstraints([NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: label, attribute: .CenterX, multiplier: 1, constant: 0),NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: label, attribute: .Top, multiplier: 1, constant: 0), NSLayoutConstraint(item: self, attribute: .Left, relatedBy: .Equal, toItem: label, attribute: .Left, multiplier: 1, constant: 0),NSLayoutConstraint(item: self, attribute: .Right, relatedBy: .Equal, toItem: label, attribute: .Right, multiplier: 1, constant: 0),NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 50)])
    }
}
class MCOption:UIView {
    var text:UILabel
    var selectBox:UIButton
    var isCorrect:Bool
    init(text:String,Correct:Bool, superr:UIView) {
        self.text = UILabel(frame: CGRectZero)
        self.text.text = text
        self.text.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.4)
        selectBox = UIButton()
        isCorrect = Correct
        super.init(frame: CGRectZero)
        selectBox.setBackgroundImage(UIImage(named: "OptionButton"), forState: .Normal)
        self.selectBox.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        self.selectBox.contentMode = .ScaleAspectFit
        self.addSubview(self.text)
        self.addSubview(selectBox)
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.selectBox.setTranslatesAutoresizingMaskIntoConstraints(false)
        selectBox.backgroundColor = UIColor.blueColor()
        selectBox.titleLabel?.textAlignment = .Center
        self.text.textAlignment = .Center
        self.text.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.addConstraint(NSLayoutConstraint(item: self.text, attribute: .Left, relatedBy: .Equal, toItem: selectBox, attribute: .Right, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: self.text, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 0.90, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.text, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.text, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.text, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: self.selectBox, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.selectBox, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 0.10, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.selectBox, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.selectBox, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0))
        self.selectBox.addTarget(self.superview, action: "hello:", forControlEvents: .TouchUpInside)

    }

    required init(coder aDecoder: NSCoder) {
        self.text = UILabel(frame: CGRectZero)
        self.text.text = "Hello"
        selectBox = UIButton()
        selectBox.setTitle("", forState: .Normal)
        self.text.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.4)
        selectBox.backgroundColor = UIColor.blueColor()
        selectBox.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        selectBox.titleLabel?.textAlignment = .Center
        selectBox.setBackgroundImage(UIImage(named: "OptionButton"), forState: .Normal)
        self.text.textAlignment = .Center
        isCorrect = false
        super.init(frame: CGRectZero)
        self.addSubview(self.text)
        self.addSubview(selectBox)
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.selectBox.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.text.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        
        self.addConstraint(NSLayoutConstraint(item: self.text, attribute: .Left, relatedBy: .Equal, toItem: selectBox, attribute: .Right, multiplier: 1, constant: 0))

        self.addConstraint(NSLayoutConstraint(item: self.text, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 0.90, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.text, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.text, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.text, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: self.selectBox, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.selectBox, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 0.10, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.selectBox, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.selectBox, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0))

    }
}
*/


