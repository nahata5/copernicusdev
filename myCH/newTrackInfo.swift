//
//  newTrackInfo.swift
//  myCH
//
//  Created by Jeet Patel on 3/15/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit
var vitalsDel = vitalsDelegate()
class newTrackInfo:UIViewController {
    @IBAction func moveToLabs(sender: AnyObject) {
        if vitalsDel.submit(false) {
            var storyBoard = self.navigationController?.storyboard!
            var vc = storyBoard!.instantiateViewControllerWithIdentifier("LabForms")! as UIViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func submit(sender: AnyObject) {
        if vitalsDel.submit(true) {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    @IBOutlet var addLabs: UIButton!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var vitalsTable: UITableView!
    @IBAction func switchSubmits(sender: AnyObject) {
        var s = sender as UISwitch
        if s.on {
            addLabs.hidden = false
            addLabs.userInteractionEnabled = true
            submitButton.hidden = true
            submitButton.userInteractionEnabled = false
            vitalsDel.rows = 7
            vitalsTable.reloadData()
        } else {
            addLabs.hidden = true
            addLabs.userInteractionEnabled = false
            submitButton.hidden = false
            submitButton.userInteractionEnabled = true
            vitalsDel.rows = 5
            vitalsTable.reloadData()
        }
    }
    @IBAction func heightWeight(sender: AnyObject) {
        vitalsDel.changedHeightWeight(sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vitalsTable.dataSource = vitalsDel
        vitalsTable.delegate = vitalsDel
        vitalsTable.layer.borderColor = UIColor.lightGrayColor().CGColor
        vitalsTable.layer.borderWidth = 0.5
        addLabs.hidden = true
        addLabs.userInteractionEnabled = false
        submitButton.hidden = false
        submitButton.userInteractionEnabled = true
    }
}