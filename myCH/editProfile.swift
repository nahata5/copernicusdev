//
//  editProfile.swift
//  myCH
//
//  Created by Jeet Patel on 3/17/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import Foundation
import UIKit

class editProfile:UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    var selectedField:UIView?
    @IBOutlet var userRegistration: UITableView!
    
    @IBAction func submit(sender: AnyObject) {
        submit()
    }
    var table:UITableView?
    var dismiss = UITapGestureRecognizer()
    var name = currentUser!.name
    var address = currentUser!.address
    var city = currentUser!.city
    var state = currentUser!.state
    var zipcode:String = currentUser!.zipcode
    var doctor:String = currentUser!.doctor
    var insurer:String = currentUser!.insurer
    var username:String = currentUser!.username
    var password:String = currentUser!.password
    var height:Double = currentUser!.height

    override func viewDidLoad() {
        super.viewDidLoad()
        println(currentUser?.username)
        userRegistration.delegate = self
        userRegistration.dataSource = self
        userRegistration.layer.borderColor = UIColor.lightGrayColor().CGColor
        userRegistration.layer.borderWidth = 0.5
        self.automaticallyAdjustsScrollViewInsets = false
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("name") as UITableViewCell
            var field = (cell.viewWithTag(2) as UITextField)
            field.autocapitalizationType = UITextAutocapitalizationType.Words
            field.autocorrectionType = UITextAutocorrectionType.No
            field.text = name
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("address") as UITableViewCell
            var field = (cell.viewWithTag(2) as UITextField)
            field.autocapitalizationType = UITextAutocapitalizationType.Words
            field.autocorrectionType = UITextAutocorrectionType.No
            field.text = address
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("address2") as UITableViewCell
            cell.viewWithTag(1)?.setTranslatesAutoresizingMaskIntoConstraints(false)
            cell.viewWithTag(2)?.setTranslatesAutoresizingMaskIntoConstraints(false)
            cell.viewWithTag(3)?.setTranslatesAutoresizingMaskIntoConstraints(false)
            (cell.viewWithTag(3)? as UITextField).keyboardType = .NumberPad
            cell.addConstraints([NSLayoutConstraint(item: cell.viewWithTag(1)!, attribute: .Width, relatedBy: .Equal, toItem: cell, attribute: .Width, multiplier: 0.4, constant: 0)])
            
            (cell.viewWithTag(1) as UITextField).autocapitalizationType = UITextAutocapitalizationType.Words
            (cell.viewWithTag(1) as UITextField).autocorrectionType = UITextAutocorrectionType.No
            
            (cell.viewWithTag(2) as UITextField).autocapitalizationType = UITextAutocapitalizationType.AllCharacters
            (cell.viewWithTag(2) as UITextField).autocorrectionType = UITextAutocorrectionType.No
            (cell.viewWithTag(3) as UITextField).delegate = self
            (cell.viewWithTag(1) as UITextField).delegate = self
            
            (cell.viewWithTag(3) as UITextField).autocapitalizationType = UITextAutocapitalizationType.Words
            (cell.viewWithTag(3) as UITextField).autocorrectionType = UITextAutocorrectionType.No
            cell.addConstraints([NSLayoutConstraint(item: cell.viewWithTag(2)!, attribute: .Width, relatedBy: .Equal, toItem: cell, attribute: .Width, multiplier: 0.2, constant: 0)])
            (cell.viewWithTag(1) as UITextField).text = city
            (cell.viewWithTag(2) as UITextField).text = state
            (cell.viewWithTag(3) as UITextField).text = zipcode
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier("height") as UITableViewCell
            var field = (cell.viewWithTag(2) as UITextField)
            field.text = String(format: "%0.1f", height)
            field.keyboardType = UIKeyboardType.DecimalPad
            field.autocorrectionType = .No
        case 4:
            cell = tableView.dequeueReusableCellWithIdentifier("doctor") as UITableViewCell
            var field = (cell.viewWithTag(2) as UITextField)
            field.text = doctor
            field.autocapitalizationType = UITextAutocapitalizationType.Words
            field.autocorrectionType = .No
        case 5:
            cell = tableView.dequeueReusableCellWithIdentifier("insurer") as UITableViewCell
            var field = (cell.viewWithTag(2) as UITextField)
            field.text = insurer
            field.autocapitalizationType = UITextAutocapitalizationType.Words
            field.autocorrectionType = .No
        case 6:
            cell = tableView.dequeueReusableCellWithIdentifier("username") as UITableViewCell
            var field = (cell.viewWithTag(2) as UITextField)
            field.text = username
            println(username)
            field.autocapitalizationType = UITextAutocapitalizationType.None
            field.autocorrectionType = .No
        default:
            println()
        }
        var fieldd = (cell.viewWithTag(2) as UITextField)
        fieldd.delegate = self
        cell.selectionStyle = UITableViewCellSelectionStyle.Default
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var label = tableView.cellForRowAtIndexPath(indexPath)!.viewWithTag(2)! as UITextField
        label.userInteractionEnabled = true
        label.becomeFirstResponder()
        print("okay")
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        selectedField = textField
        textField.superview!.superview?.backgroundColor = UIColor.whiteColor()
        textField.backgroundColor = UIColor.whiteColor()
        var cell = (textField.superview!.superview! as UITableViewCell)
        userRegistration.setContentOffset(CGPoint(x: 0, y: cell.frame.minY-44), animated: true)
        dismiss = UITapGestureRecognizer(target: self, action: "resign:")
        view.addGestureRecognizer(dismiss)
    }
    func textFieldDidEndEditing(textField: UITextField) {
        var id = (textField.superview!.superview! as UITableViewCell).reuseIdentifier!
        switch id {
        case "name":
            name = textField.text
        case "address":
            address = textField.text
        case "address2":
            if textField.tag == 1 {
                city = textField.text
            } else if textField.tag == 2 {
                state = textField.text
            } else if textField.tag == 3 {
                zipcode = textField.text
            }
        case "height":
            height = NSString(string: textField.text).doubleValue
        case "doctor":
            doctor = textField.text
        case "insurer":
            insurer = textField.text
        case "username":
            username = textField.text
        default:
            println()
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        userRegistration.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        textField.resignFirstResponder()
        view.removeGestureRecognizer(dismiss)
        userRegistration.reloadData()
        return true
    }
    func resign(sender:AnyObject) {
        view.endEditing(true)
        userRegistration.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return 44
        }
        return 44
    }
    
    
    func submit() {
        var name:String?
        var address:String?
        var city:String?
        var state:String?
        var zipcode:String?
        var doctor:String?
        var insurer:String?
        var username:String?
        var height:Double?
        var submittable = true
        var cells = userRegistration.visibleCells() as [UITableViewCell]
        for cell in cells {
            switch cell.reuseIdentifier! {
            case "name":
                var label = cell.viewWithTag(2) as UITextField
                if label.text == "" {
                    cell.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                    submittable = false
                } else {
                    name = label.text
                }
            case "address":
                var label = cell.viewWithTag(2) as UITextField
                if label.text == "" {
                    cell.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                    submittable = false
                } else {
                    address = label.text
                }
            case "address2":
                var c = cell.viewWithTag(1) as UITextField
                var s = cell.viewWithTag(2) as UITextField
                var z = cell.viewWithTag(3) as UITextField
                if c.text == "" {
                    c.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                    submittable = false
                }
                if s.text == "" {
                    s.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                    submittable = false
                }
                if z.text == "" {
                    z.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                    submittable = false
                }
                city = c.text
                state = s.text
                zipcode = z.text
            case "doctor":
                var label = cell.viewWithTag(2) as UITextField
                if label.text == "" {
                    cell.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                    submittable = false
                } else {
                    doctor = label.text
                }
            case "insurer":
                var label = cell.viewWithTag(2) as UITextField
                if label.text == "" {
                    cell.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                    submittable = false
                } else {
                    insurer = label.text
                }
            case "username":
                var label = cell.viewWithTag(2) as UITextField
                if label.text == "" {
                    cell.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                    submittable = false
                } else {
                    username = label.text
                }
            case "height":
                var label = cell.viewWithTag(2) as UITextField
                if label.text == "" {
                    cell.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                    submittable = false
                } else {
                    height = NSString(string: label.text).doubleValue
                }
            default:
                print()
            }
        }
        if submittable {
            println(true)
            var c = userProfile(name: name!, address: address!, city: city!, state: state!, zipcode: zipcode!, doctor: doctor!, insurer: insurer!, username: username!, password: currentUser!.password, height: height!)
            currentUser = c
            var a = NSKeyedUnarchiver.unarchiveObjectWithData(userdefaults.objectForKey("users") as NSData) as [userProfile]
            for(var i=0; i<a.count;i++) {
                if a[i].username == currentUser?.username {
                    a[i] = c
                    break
                }
            }
            var data = NSKeyedArchiver.archivedDataWithRootObject(a) as NSData
            userdefaults.setObject(data, forKey: "users")
            userdefaults.synchronize()
            self.navigationController?.popToRootViewControllerAnimated(true)
        } else {
           println(false)
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 0, constant: 44*7))
        table = tableView
        return 7
    }
}