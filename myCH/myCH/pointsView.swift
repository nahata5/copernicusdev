//
//  pointsView.swift
//  myCH
//
//  Created by Jeet Patel on 3/27/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit

class pointsView:UIView {
    var pointsLabel = UILabel()
    var numberLabel = UILabel()
    var isPresent = false
    init(View:UIView) {
        var height = UIScreen.mainScreen().bounds
        super.init(frame: CGRect(x: height.midX-View.frame.width/4, y: height.midY-View.frame.width/4, width: View.frame.width/2, height: View.frame.width/2))
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        numberLabel.textAlignment = NSTextAlignment.Center
        numberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: View.frame.width/2, height: self.frame.height*0.85))
        pointsLabel = UILabel(frame: CGRect(x: 0, y: numberLabel.frame.maxY, width: View.frame.width/2, height: self.frame.height*0.15))
        self.addSubview(numberLabel)
        self.addSubview(pointsLabel)
        
        pointsLabel.baselineAdjustment = .AlignCenters
        pointsLabel.textColor = .whiteColor()
        //pointsLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        pointsLabel.textAlignment = .Center

        numberLabel.textAlignment = .Center
        numberLabel.baselineAdjustment = .AlignCenters
        numberLabel.textColor = .whiteColor()
        //numberLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
     /*   self.addConstraints([
            NSLayoutConstraint(item: numberLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: numberLabel, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: numberLabel, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: numberLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0.80, constant: 0)])
       
        self.addConstraints([
            NSLayoutConstraint(item: pointsLabel, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: pointsLabel, attribute: .Top, relatedBy: .Equal, toItem: numberLabel, attribute: .Bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: pointsLabel, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: pointsLabel, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: pointsLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0.15, constant: 0)
            ])
    */
        self.layer.cornerRadius = 5
        
    }
    
    func presentInView(view:UIView) {
        view.addSubview(self)
        var height = UIScreen.mainScreen().bounds
        var View = view
        self.frame = CGRect(x: height.midX-View.frame.width/4, y: height.midY-height.width/4, width: height.width/2, height: height.width/2)
        self.alpha = 0
        view.bringSubviewToFront(self)
        UIView.animateWithDuration(0.2, animations: {self.alpha = 1},completion: {(bool) in
            sleep(1);
            UIView.animateWithDuration(0.3, animations: {
                self.alpha = 0
                }, completion: {(bool) in
                self.removeFromSuperview()
            })
        
        })
    }

    func presentPoints(view:UIView, mainText:String) {
        presentInView(view)
        numberLabel.numberOfLines = 1
        numberLabel.text = mainText
        numberLabel.adjustsFontSizeToFitWidth = true
        numberLabel.font = UIFont(name: "Raleway", size: 100)
        numberLabel.baselineAdjustment = UIBaselineAdjustment.AlignCenters
        numberLabel.sizeThatFits(CGSize(width: self.frame.width*0.85, height: self.frame.height*0.85))
        
        pointsLabel.text = "Points"
        pointsLabel.numberOfLines = 1
        pointsLabel.font = UIFont(name: "Raleway", size: 30)
        pointsLabel.adjustsFontSizeToFitWidth = true
        pointsLabel.baselineAdjustment = UIBaselineAdjustment.AlignCenters
        pointsLabel.sizeThatFits(CGSize(width: self.frame.size.width*0.15, height: self.frame.size.height*0.15))
    }
    required init(coder aDecoder: NSCoder) {
        super.init(frame: CGRectZero)
        self.frame = CGRect(x: 2, y: 2, width: superview!.frame.width/2, height: superview!.frame.width/2)
    }
}