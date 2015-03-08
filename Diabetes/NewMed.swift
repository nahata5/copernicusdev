//
//  NewMed.swift
//  Diabetes
//
//  Created by Jeet Patel on 2/18/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit

var tableDel = dosesTable()
class NewMedVC: UIViewController {
    
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var daySelects: daySelector!
    @IBOutlet var doseTable: UITableView!
    
    //Refill IBOutlets
    @IBOutlet var viewBottom: NSLayoutConstraint!
    @IBOutlet var viewTop: NSLayoutConstraint!
    @IBOutlet var buttonBottom: NSLayoutConstraint!
    @IBOutlet var refillView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    
    var tableHeightConstraint:NSLayoutConstraint?
    override func viewDidLoad() {
       NSNotificationCenter.defaultCenter().addObserver(self, selector: "addRow:", name: "TableDidAddRow", object: nil)
        doseTable.dataSource = tableDel
        doseTable.delegate = tableDel
        tableDel.table = doseTable
        daySelects.start(doseTable.superview!)
        cameraButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        //buttonBottom.active = false
    }
    
    func addRow(notif:NSNotification) {
        var info = notif.userInfo! as [String:AnyObject]
        print("posted")
        if(tableHeightConstraint != nil) {
            view.removeConstraint(tableHeightConstraint!)
        }
        var rows = info["rows"]! as Int
        var height = info["height"]! as CGFloat
        var total = CGFloat(rows)
        println(total)
        println(height)
        tableHeightConstraint = NSLayoutConstraint(item: doseTable, attribute: .Height, relatedBy: .Equal, toItem: nil , attribute: .NotAnAttribute, multiplier: 1, constant: total*44 )
        view.addConstraint(tableHeightConstraint!)
        var scrollHeight:CGFloat = 0
        for views in scrollView.subviews {
            scrollHeight+=view.frame.height
        }
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: scrollHeight) 
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
