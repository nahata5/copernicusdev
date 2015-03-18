//
//  trackVC.swift
//  myCH
//
//  Created by Jeet Patel on 3/15/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit
class trackVC:UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var scoreField: UILabel!
    @IBOutlet var progressB: UIView!
    @IBOutlet var completedProgressB: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var mainView: UIView!
    var progressCompleted = NSLayoutConstraint()
    override func viewDidLoad() {
        mainView.layer.cornerRadius = 10
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clearColor()
        var pct = scoreField.text!.toInt()!
        var pctt = Double(pct)/100.00
        self.progressCompleted = NSLayoutConstraint(item: self.completedProgressB, attribute: .Width, relatedBy: .Equal, toItem: self.progressB, attribute: .Width, multiplier: 0, constant: 0)
        view.addConstraint(progressCompleted)
        view.removeConstraint(progressCompleted)
        self.progressCompleted = NSLayoutConstraint(item: self.completedProgressB, attribute: .Width, relatedBy: .Equal, toItem: self.progressB, attribute: .Width, multiplier: CGFloat(pctt), constant: 0)
        self.view.addConstraint(self.progressCompleted)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("hba1c") as UITableViewCell
            cell.addConstraint(NSLayoutConstraint(item: cell.viewWithTag(2)!.viewWithTag(3)!, attribute: .Width, relatedBy: .Equal, toItem: cell.viewWithTag(2), attribute: .Width, multiplier: 0.6, constant: 0))
            (cell.viewWithTag(4) as UILabel).text = "60%"
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("bmi") as UITableViewCell
            cell.addConstraint(NSLayoutConstraint(item: cell.viewWithTag(2)!.viewWithTag(3)!, attribute: .Width, relatedBy: .Equal, toItem: cell.viewWithTag(2), attribute: .Width, multiplier: 0.75, constant: 0))
            (cell.viewWithTag(4) as UILabel).text = "75%"

        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("medadherence") as UITableViewCell
            cell.addConstraint(NSLayoutConstraint(item: cell.viewWithTag(2)!.viewWithTag(3)!, attribute: .Width, relatedBy: .Equal, toItem: cell.viewWithTag(2), attribute: .Width, multiplier: 0.86, constant: 0))
            (cell.viewWithTag(4) as UILabel).text = "86%"

        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier("bp") as UITableViewCell
            cell.addConstraint(NSLayoutConstraint(item: cell.viewWithTag(2)!.viewWithTag(3)!, attribute: .Width, relatedBy: .Equal, toItem: cell.viewWithTag(2), attribute: .Width, multiplier: 0.8, constant: 0))
            (cell.viewWithTag(4) as UILabel).text = "80%"
        case 4:
            cell = tableView.dequeueReusableCellWithIdentifier("quizperformance") as UITableViewCell
            cell.addConstraint(NSLayoutConstraint(item: cell.viewWithTag(2)!.viewWithTag(3)!, attribute: .Width, relatedBy: .Equal, toItem: cell.viewWithTag(2), attribute: .Width, multiplier: 0.96, constant: 0))
            (cell.viewWithTag(4) as UILabel).text = "96%"

        default:
            return cell
        }
        cell.addConstraint(NSLayoutConstraint(item: cell.viewWithTag(1)!, attribute: .Width, relatedBy: .Equal, toItem: cell, attribute: .Width, multiplier: 0.4, constant: 0))
        cell.addConstraint(NSLayoutConstraint(item: cell.viewWithTag(2)!, attribute: .Height, relatedBy: .Equal, toItem: cell, attribute: .Height, multiplier: 0.1, constant: 0))
        cell.addConstraint(NSLayoutConstraint(item: cell.viewWithTag(2)!, attribute: .Width, relatedBy: .Equal, toItem: cell, attribute: .Width, multiplier: 0.4, constant: 0))

        //cell = tableView.dequeueReusableCellWithIdentifier("progress") as UITableViewCell
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.superview!.frame.height*0.8/5
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}

class progressBar:UIView {
    var completed = UIView(frame: CGRectZero)
    var progress:NSLayoutConstraint?
    var label = UILabel()
    override init() {
        super.init(frame: CGRectZero)
        self.addSubview(completed)
        var constraints = [NSLayoutConstraint(item: completed, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0), NSLayoutConstraint(item: completed, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0),NSLayoutConstraint(item: completed, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)]
        self.addConstraints(constraints)
    }
    func setProgress(fraction:Double) {
        if progress == nil {
            progress = NSLayoutConstraint(item: completed, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: CGFloat(fraction), constant: 0)
            self.addConstraint(progress!)
        } else {
            self.removeConstraint(progress!)
            progress = NSLayoutConstraint(item: completed, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: CGFloat(fraction), constant: 0)
            self.addConstraint(progress!)
        }
        completed.addSubview(label)
        label.center = completed.center
        var num = Int(fraction * 100)
        label.text = "\(num)%"
    }
    func setColor(bar:UIColor, selected:UIColor) {
        self.backgroundColor = bar
        completed.backgroundColor = selected
    }

    required init(coder aDecoder: NSCoder) {
        super.init(frame: CGRectZero)
        self.addSubview(completed)
        completed.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        var constraints = [NSLayoutConstraint(item: completed, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0), NSLayoutConstraint(item: completed, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0),NSLayoutConstraint(item: completed, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)]
        self.addConstraints(constraints)
    }
}