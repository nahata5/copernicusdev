//
//  dpicker.swift
//  Diabetes
//
//  Created by Jeet Patel on 3/5/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit
class dpicker:UIDatePicker {
    var button = UIButton(frame: CGRectZero)
    var cellRow = -1
    var cell:UITableViewCell?
    var isPresented = false
    override init(frame: CGRect) {
        super.init(frame: CGRectZero)
    }
    
    override init() {
        super.init()
        button.addTarget(self, action: "close", forControlEvents: .TouchUpInside)
        self.tintColor = UIColor.whiteColor()
        self.datePickerMode = UIDatePickerMode.Time
        self.minuteInterval = 30
    }
    
    func setUpButton(supervw:UIView) {
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.setTitle("Done", forState: .Normal)
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        button.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
    }
    func setUpConstraints(supervw:UIView) {
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        supervw.addSubview(button)
        supervw.addSubview(self)
        self.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.5)
        supervw.addSubview(self)
        var a = NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: supervw, attribute: .Bottom, multiplier: 1, constant: 0)
        var b = NSLayoutConstraint(item: self, attribute: .Left, relatedBy: .Equal, toItem: supervw, attribute: .Left, multiplier: 1, constant: 0)
        var c = NSLayoutConstraint(item: self, attribute: .Right, relatedBy: .Equal, toItem: supervw, attribute: .Right, multiplier: 1, constant: 0)
        var d = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: supervw, attribute: .Right, multiplier: 1, constant: 0)
        var e = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: supervw, attribute: .Left, multiplier: 1, constant: 0)
        var f = NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0.2, constant: 0)
        var g = NSLayoutConstraint(item: button, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0)
        supervw.addConstraints([a,b,c,d,e,f,g])
    }
    
    func present(superv:UIView) {
        if(!isPresented) {
            setUpConstraints(superv)
            setUpButton(superv)
            self.alpha = 0
            button.alpha = 0
            UIView.animateWithDuration(0.5, animations: {
                self.alpha=1
                self.button.alpha=1
            })
        }
    }
    func present(superv:UIView, withDate:String) {
        if(isPresented) {
            var s = NSDateFormatter()
            s.dateFormat = "hh:mm"
            self.date = s.dateFromString(withDate)!
        } else {
            setUpConstraints(superv)
            setUpButton(superv)
            self.alpha = 0
            button.alpha = 0
            UIView.animateWithDuration(0.5, animations: {
                self.alpha=1
                self.button.alpha=1
            })
            isPresented = true
        }
        
    }
    
    func close() {
        UIView.animateWithDuration(0.5, animations: {
            self.alpha = 0
            self.button.alpha = 0
            }, completion: {(bool) in
                self.removeFromSuperview()
                self.button.removeFromSuperview()
                self.isPresented = false
        })
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "PickerDidReturnDate", object: nil, userInfo: ["date":self.date]))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("\(aDecoder)")
    }
}

