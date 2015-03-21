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
    
    func setTable(type:String, forItem:AnyObject) {
        switch type {
        case "Medicine":
            medicineTable.hidden = false
            medicineTable.delegate = medE
            medicineTable.dataSource = medE
            doctorTable.hidden = true
            labTable.hidden = true
        case "Doctor":
            medicineTable.hidden = true
            doctorTable.hidden = false
            docE.setData(item! as DoctorAppointment)
            doctorTable.delegate = docE
            doctorTable.dataSource = docE
            labTable.hidden = true
        case "Lab":
            medicineTable.hidden = true
            doctorTable.hidden = true
            labTable.hidden = false
            labTable.delegate = labE
            labTable.dataSource = labE
        default:
            println()
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setTable(type, forItem: item!)
    }
    override func viewDidLoad() {
    }

}