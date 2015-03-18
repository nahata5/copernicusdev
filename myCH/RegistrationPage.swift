//
//  RegistrationPage.swift
//  myCH
//
//  Created by Jeet Patel on 3/16/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit

class RegistrationPage:UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    var selectedField:UIView?
    @IBOutlet var userRegistration: UITableView!
    
    @IBAction func cancel(sender: AnyObject) {
        if isgoingToEditProfile {
            var s = storyboard?.instantiateViewControllerWithIdentifier("tab") as UIViewController
                self.presentViewController(s, animated: true, completion: nil)
        } else {
            var s:UIViewController = storyboard?.instantiateInitialViewController() as UIViewController
            self.presentViewController(s, animated: true, completion: nil)
        }
    }
    @IBAction func submit(sender: AnyObject) {
        if isgoingToEditProfile {} else {
        submit()
        }
    }
    var table:UITableView?
    var profile:userProfile?
    var isgoingToEditProfile = false
    var dismiss = UITapGestureRecognizer()
    override func viewDidLoad() {
        super.viewDidLoad()
        userRegistration.delegate = self
        userRegistration.dataSource = self
        userRegistration.layer.borderColor = UIColor.lightGrayColor().CGColor
        userRegistration.layer.borderWidth = 0.5
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("name") as UITableViewCell
            var field = (cell.viewWithTag(2) as UITextField)
            field.autocapitalizationType = UITextAutocapitalizationType.Words
            field.autocorrectionType = UITextAutocorrectionType.No
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("address") as UITableViewCell
            var field = (cell.viewWithTag(2) as UITextField)
            field.autocapitalizationType = UITextAutocapitalizationType.Words
            field.autocorrectionType = UITextAutocorrectionType.No
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
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier("height") as UITableViewCell
            var field = (cell.viewWithTag(2) as UITextField)
            field.keyboardType = UIKeyboardType.DecimalPad
            field.autocorrectionType = .No
        case 4:
            cell = tableView.dequeueReusableCellWithIdentifier("doctor") as UITableViewCell
            var field = (cell.viewWithTag(2) as UITextField)
            field.autocapitalizationType = UITextAutocapitalizationType.Words
            field.autocorrectionType = .No
        case 5:
            cell = tableView.dequeueReusableCellWithIdentifier("insurer") as UITableViewCell
            var field = (cell.viewWithTag(2) as UITextField)
            field.autocapitalizationType = UITextAutocapitalizationType.Words
            field.autocorrectionType = .No
        case 6:
            cell = tableView.dequeueReusableCellWithIdentifier("username") as UITableViewCell
            var field = (cell.viewWithTag(2) as UITextField)
            field.autocapitalizationType = UITextAutocapitalizationType.None
            field.autocorrectionType = .No
        case 7:
            cell = tableView.dequeueReusableCellWithIdentifier("password") as UITableViewCell
            var field = (cell.viewWithTag(2) as UITextField)
            field.autocapitalizationType = UITextAutocapitalizationType.None
            field.autocorrectionType = .No
            field.secureTextEntry = true
            if isgoingToEditProfile {
                return UITableViewCell()
            }
        case 8:
            cell = tableView.dequeueReusableCellWithIdentifier("password2") as UITableViewCell
            
            var field = (cell.viewWithTag(2) as UITextField)
            field.autocapitalizationType = UITextAutocapitalizationType.None
            field.autocorrectionType = .No
            field.secureTextEntry = true
            if isgoingToEditProfile {
                return UITableViewCell()
            }
        default:
            println()
        }
        if isgoingToEditProfile {
            var cells = userRegistration.visibleCells() as [UITableViewCell]
            var pro = NSKeyedUnarchiver.unarchiveObjectWithData(userdefaults.valueForKey("currentUser") as NSData) as userProfile
            for cell in cells {
                var field = cell.viewWithTag(2) as UITextField
                switch cell.reuseIdentifier! {
                case "name":
                    field.text = pro.name
                case "address":
                    field.text = pro.address
                case "address2":
                    var city = cell.viewWithTag(1) as UITextField
                    var zip = cell.viewWithTag(3) as UITextField
                    field.text = pro.state
                    zip.text = pro.zipcode
                    city.text = pro.city
                case "height":
                    field.text = String(format: "%0.1f", profile!.height)
                case "doctor":
                    field.text = pro.doctor
                case "insurer":
                    field.text = pro.insurer
                case "username":
                    field.text = pro.username
                default:
                    println()
                }
            }
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
        dismiss = UITapGestureRecognizer(target: self, action: "resign")
        view.addGestureRecognizer(dismiss)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        userRegistration.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        textField.resignFirstResponder()
        view.removeGestureRecognizer(dismiss)
        userRegistration.reloadData()
        return true
    }
    func resign() {
        view.endEditing(true)
        userRegistration.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        userRegistration.reloadData()
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
        var password:String?
        var pass1Cell:UITableViewCell?
        var pass2Cell:UITableViewCell?
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
            case "password":
                var label = cell.viewWithTag(2) as UITextField
                if label.text == "" {
                    cell.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                    submittable = false

                } else {
                    pass1Cell = cell
                    password = label.text
                }
            case "password2":
                var label = cell.viewWithTag(2) as UITextField
                if label.text == "" {
                    cell.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                    submittable = false
                } else {
                    if password != label.text {
                        pass1Cell!.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                        cell.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
                        submittable = false
                    }
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
            var c = userProfile(name: name!, address: address!, city: city!, state: state!, zipcode: zipcode!, doctor: doctor!, insurer: insurer!, username: username!, password: password!, height: height!)
            println(c.username)
            currentUser = c
            loginBE.register(c)
            userdefaults.setBool(true, forKey: "isLoggedIn")
            userdefaults.synchronize()
            var t = storyboard?.instantiateViewControllerWithIdentifier("tab") as UIViewController
            self.presentViewController(t, animated: true, completion: nil)
        } else {
        
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 0, constant: 44*9))
        table = tableView
        return 9
    }
}