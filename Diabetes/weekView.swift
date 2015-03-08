//
//  weekView.swift
//  Diabetes
//
//  Created by Jeet Patel on 3/5/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit
class dayButton: UIButton {
    var day:days
    var highlight:Bool
    var bgColor:UIColor = UIColor.whiteColor()
    var selectedColor:UIColor = UIColor.greenColor()
    init(title:String, day:days) {
        highlight = false
        self.day = day
        super.init(frame: CGRectZero)
        self.setTitle(title, forState: .Normal)
        self.setTitleColor(UIColor.blueColor(), forState: .Normal)
        self.addTarget(self, action: "getSelected", forControlEvents: .TouchUpInside)
    }
    func getSelected(){
        if highlight {
            highlight = false
            self.backgroundColor = bgColor
        } else {
            highlight = true
            self.backgroundColor = selectedColor
        }
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class daySelector:UIView {
    var dayOfWeek:[dayButton]?
    override init(frame: CGRect) {
        super.init(frame: CGRectZero)
    }
    init(sup:UIView){
        var mon = dayButton(title: "Mon", day: .Monday)
        var tues = dayButton(title: "Tues", day: .Tuesday)
        var wed = dayButton(title: "Wed", day: .Wednesday)
        var thurs = dayButton(title: "Thurs", day: .Thursday)
        var fri = dayButton(title: "Fri", day: .Friday)
        var sat = dayButton(title: "Sat", day: .Saturday)
        var sun = dayButton(title: "Sun", day: .Sunday)
        super.init()
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        sup.addSubview(self)
        sup.addConstraint(NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: sup, attribute: .Height, multiplier: 0.1, constant: 0))
        sup.addConstraint(NSLayoutConstraint(item: self, attribute: .Width , relatedBy: .Equal, toItem: sup, attribute: .Width, multiplier: 0.95, constant: 0))
        sup.addConstraint(NSLayoutConstraint(item: self, attribute: .CenterX , relatedBy: .Equal, toItem: sup, attribute: .CenterX, multiplier: 1, constant: 0))

        dayOfWeek = [mon,tues,wed,thurs,fri,sat,sun]
        for(var i=0; i<dayOfWeek!.count;i++) {
            var button = dayOfWeek![i]
            self.addSubview(button)
            button.setTranslatesAutoresizingMaskIntoConstraints(false)
            if(i == 0){
                button.setBackgroundImage(UIImage(named: "BorderLeft"), forState: .Normal)
                sup.addConstraint(NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0))
            } else if(i == dayOfWeek!.count-1) {
                button.setBackgroundImage(UIImage(named: "BorderRight"), forState: .Normal)
                sup.addConstraint(NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem:self, attribute: .Right, multiplier: 1, constant: 0))
                sup.addConstraint(NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: dayOfWeek![i-1], attribute: .Right, multiplier: 1, constant: 0))
                sup.addConstraint(NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: dayOfWeek![0], attribute: .Width, multiplier: 1, constant: 0))
            } else {
                button.setBackgroundImage(UIImage(named: "BorderMid"), forState: .Normal)
                sup.addConstraint(NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: dayOfWeek![0], attribute: .Width, multiplier: 1, constant: 0))
                sup.addConstraint(NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: dayOfWeek![i-1], attribute: .Right, multiplier: 1, constant: 0))
            }
            sup.addConstraint(NSLayoutConstraint(item: button, attribute: .Top , relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0))
            sup.addConstraint(NSLayoutConstraint(item: button, attribute: .Bottom , relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0))

        }
        for day in dayOfWeek! {
            day.titleLabel?.adjustsFontSizeToFitWidth = true
        }
    }
    func getSelected() -> [days] {
        var final:[days] = []
        for day in dayOfWeek! {
            if day.highlight {
                final.append(day.day)
            }
        }
        return final
    }
    func start(sup:UIView) {
        var mon = dayButton(title: "Mon", day: .Monday)
        var tues = dayButton(title: "Tues", day: .Tuesday)
        var wed = dayButton(title: "Wed", day: .Wednesday)
        var thurs = dayButton(title: "Thurs", day: .Thursday)
        var fri = dayButton(title: "Fri", day: .Friday)
        var sat = dayButton(title: "Sat", day: .Saturday)
        var sun = dayButton(title: "Sun", day: .Sunday)
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        sup.addSubview(self)
        sup.addConstraint(NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: sup, attribute: .Height, multiplier: 0.1, constant: 0))
        sup.addConstraint(NSLayoutConstraint(item: self, attribute: .Width , relatedBy: .Equal, toItem: sup, attribute: .Width, multiplier: 0.95, constant: 0))
        sup.addConstraint(NSLayoutConstraint(item: self, attribute: .CenterX , relatedBy: .Equal, toItem: sup, attribute: .CenterX, multiplier: 1, constant: 0))
        
        dayOfWeek = [mon,tues,wed,thurs,fri,sat,sun]
        for(var i=0; i<dayOfWeek!.count;i++) {
            var button = dayOfWeek![i]
            self.addSubview(button)
            button.setTranslatesAutoresizingMaskIntoConstraints(false)
            if(i == 0){
                button.setBackgroundImage(UIImage(named: "BorderLeft"), forState: .Normal)
                sup.addConstraint(NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0))
            } else if(i == dayOfWeek!.count-1) {
                button.setBackgroundImage(UIImage(named: "BorderRight"), forState: .Normal)
                sup.addConstraint(NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem:self, attribute: .Right, multiplier: 1, constant: 0))
                sup.addConstraint(NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: dayOfWeek![i-1], attribute: .Right, multiplier: 1, constant: 0))
                sup.addConstraint(NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: dayOfWeek![0], attribute: .Width, multiplier: 1, constant: 0))
            } else {
                button.setBackgroundImage(UIImage(named: "BorderMid"), forState: .Normal)
                sup.addConstraint(NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: dayOfWeek![0], attribute: .Width, multiplier: 1, constant: 0))
                sup.addConstraint(NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: dayOfWeek![i-1], attribute: .Right, multiplier: 1, constant: 0))
            }
            sup.addConstraint(NSLayoutConstraint(item: button, attribute: .Top , relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0))
            sup.addConstraint(NSLayoutConstraint(item: button, attribute: .Bottom , relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0))
            
        }
        for day in dayOfWeek! {
            day.titleLabel?.adjustsFontSizeToFitWidth = true
        }
    }
    required init(coder aDecoder: NSCoder) {
        println("ff")
        super.init(coder: aDecoder)
    }
}

