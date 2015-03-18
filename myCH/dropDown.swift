//
//  dropDown.swift
//  Diabetes
//
//  Created by Jeet Patel on 3/10/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit

class dropDown:UIView {
    var superv:UIView
    var tap = UITapGestureRecognizer()
    var indexPath:NSIndexPath?
    var done = UIButton()
    func present() {
        if self.hidden {
            self.hidden = false
            UIView.animateWithDuration(0.5, animations: {
                self.alpha = 1
                self.tap = UITapGestureRecognizer(target: self, action: "present")
                self.superv.addGestureRecognizer(self.tap)
            })
        } else {
            superv.removeGestureRecognizer(tap)
            UIView.animateWithDuration(0.5, animations: {
                self.alpha = 0
                }, completion: {(bool) in
                    self.hidden = true
            })
        }
    }
    func hide() {
        UIView.animateWithDuration(0.5, animations: {
            self.alpha = 0
            }, completion: {(bool) in
                self.hidden = true
        })
    }
    
    func setLoc(rect:CGRect){
        self.frame = rect
    }
    func setTag(i:Int) {
        super.tag = i
    }
    init(forCell: UITableViewCell, view:UIView, path:NSIndexPath) {
        var rforCell = view.frameForAlignmentRect(forCell.frame)
        superv = view
        indexPath = path
        super.init(frame: CGRect(x: view.frame.midX-(0.80*view.frame.width/2), y: view.frame.midX-(view.frame.height/10), width: 0.80*view.frame.width, height: view.frame.height/2.5))
        view.addSubview(self)
        view.bringSubviewToFront(self)
        self.addSubview(done)
        self.backgroundColor = UIColor(white: 1, alpha: 0.9)
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.layer.borderWidth = 0.5
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.alpha = 0
        self.hidden = true
    }
    
    required override init() {
        superv = UIView()

        super.init(frame: CGRectZero)
    }
    required init(coder aDecoder: NSCoder) {
        superv = UIView()
        super.init(frame: CGRectZero)
    }
}

