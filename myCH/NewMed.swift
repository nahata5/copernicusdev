//
//  NewMed.swift
//  Diabetes
//
//  Created by Jeet Patel on 2/18/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit

var medDel = dosesTable()
var labDel = labForm()
var drDel = DRApptForm()
var selectType = scheduleAppt()
var userChoseScheduleType = "userChoseScheduleType"
class NewMedVC: UIViewController {
    @IBOutlet var contentView: UIView!
    @IBOutlet var medicineTable: UITableView!
    @IBOutlet var submit: UIButton!
    @IBOutlet var selectTypeTable: UITableView!
    @IBOutlet var labVisitTable: UITableView!
    @IBOutlet var DRvisitTable: UITableView!
    var table:UITableView?
    @IBAction func resign(sender: AnyObject) {
        medDel.resign(sender)
    }
    
    
    override func viewDidLoad() {
        view.addConstraints([NSLayoutConstraint(item: contentView, attribute: .Left, relatedBy: .Equal, toItem: contentView, attribute: .Left, multiplier: 1, constant: 0),NSLayoutConstraint(item: contentView, attribute: .Right, relatedBy: .Equal, toItem: contentView, attribute: .Right, multiplier: 1, constant: 0),NSLayoutConstraint(item: contentView, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 0)])
        medicineTable.hidden=true
        selectTypeTable.dataSource = selectType
        selectTypeTable.delegate = selectType
        labVisitTable.hidden = true
        labVisitTable.dataSource = labDel
        labVisitTable.delegate = labDel
        DRvisitTable.hidden = true
        DRvisitTable.delegate = drDel
        DRvisitTable.dataSource = drDel
        medicineTable.hidden = true
        medicineTable.dataSource = medDel
        medicineTable.delegate = medDel
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "selectDelegate:", name: userChoseScheduleType, object: nil)
        submit.addTarget(self, action: "submitt", forControlEvents: .TouchUpInside)
    }
    
    func selectDelegate(notif:NSNotification) {
        var userinfo = notif.userInfo! as [String:AnyObject]
        switch userinfo["selected"]! as String{
        case "0":
            labVisitTable.hidden = true
            DRvisitTable.hidden = true
            medicineTable.hidden = true
            table = medicineTable
        case "1":
            labVisitTable.hidden = true
            DRvisitTable.hidden = true
            medicineTable.hidden = true
            table = DRvisitTable
        case "2":
            labVisitTable.hidden = true
            DRvisitTable.hidden = true
            medicineTable.hidden = true
            table = labVisitTable
        default:
            table = medicineTable
            print()
        }
        table!.alpha = 0
        table!.hidden = false
        UIView.animateWithDuration(0.25, animations: {
            self.table!.alpha = 1
        })
    }
    
    func submitt() {
        if selectType.selects == "Medicine" {
            if medDel.submit() {
                self.navigationController!.popToRootViewControllerAnimated(true)
            }
        }
        if selectType.selects == "Doctor" {
            if drDel.submit() {
                self.navigationController!.popToRootViewControllerAnimated(true)
                drVisit.sort({$0.date.compare($1.date) == NSComparisonResult.OrderedAscending})
            }
        }
        if selectType.selects == "Lab" {
            if labDel.submit() {
                self.navigationController!.popToRootViewControllerAnimated(true)
                labVist.sort({$0.date.compare($1.date) == NSComparisonResult.OrderedAscending})
            }
        }
    }
}




class pickerController:NSObject,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
class textDel:NSObject,UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
