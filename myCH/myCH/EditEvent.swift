//
//  EditEvent.swift
//  myCH
//
//  Created by Jeet Patel on 3/16/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit

class EditEvent:UIViewController {
    @IBOutlet var medicineTable: UITableView!
    @IBOutlet var doctorTable: UITableView!
    @IBOutlet var labTable: UITableView!
    var medE = medEdit()
    var docE = doctorEdit()
    var labE = labEdit()
    var type = ""
    var item:AnyObject?
    

    @IBAction func save(sender: AnyObject) {
        if !medicineTable.hidden {
            if medE.submit() {
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
        } else if !doctorTable.hidden {
            if docE.submit() {
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
        } else if !labTable.hidden {
            if labE.submit() {
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
        }
    }
    func setTable(type:String, forItem:AnyObject) {
        switch type {
        case "Medicine":
            medicineTable.hidden = false
            medicineTable.delegate = medE
            medicineTable.dataSource = medE
            doctorTable.hidden = true
            labTable.hidden = true
            docE.hasDoctor = false
        case "Doctor":
            medicineTable.hidden = true
            doctorTable.hidden = false
            doctorTable.delegate = docE
            doctorTable.dataSource = docE
            labTable.hidden = true
            docE.doctor = drVisit[0]
            docE.hasDoctor = true
        case "Lab":
            medicineTable.hidden = true
            doctorTable.hidden = true
            labTable.hidden = false
            labTable.delegate = labE
            labTable.dataSource = labE
            labE.hasLab = true
            labE.lab = labVist[0]
            docE.hasDoctor = false
        default:
            println()
        }
        labTable.reloadData()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLoad() {
        setTable(type, forItem: item!)
    }

}