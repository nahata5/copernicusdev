//
//  LoginVC.swift
//  myCH
//
//  Created by Jeet Patel on 3/16/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit
class LoginVC:UIViewController, UITextFieldDelegate {
    @IBOutlet var loginToTop: NSLayoutConstraint!
    @IBOutlet var CHLogo: UIImageView!
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var chlogo: UIImageView!
    func touch(sender: AnyObject) {
        loginToTop.active = false
        CHLogo.hidden=false
        welcomeLabel.hidden=false
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        passwordField.returnKeyType = UIReturnKeyType.Go
        view.removeGestureRecognizer(dismiss)
    }
    @IBAction func login(sender: AnyObject) {
        if loginBE.login(usernameField.text, password: passwordField.text){
            var c = storyboard?.instantiateViewControllerWithIdentifier("tab") as UIViewController
            self.presentViewController(c, animated: true, completion: nil)
            //userdefaults.setBool(true, forKey: "isLoggedIn")
            userdefaults.synchronize()
        } else {
            welcomeLabel.numberOfLines = 0
            welcomeLabel.text = "Error: Invalid username or password"
            usernameField.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            passwordField.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        }
    }
    var dismiss = UITapGestureRecognizer()
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.delegate = self
        usernameField.autocorrectionType = .No
        usernameField.autocapitalizationType = UITextAutocapitalizationType.None
        passwordField.delegate = self
        passwordField.returnKeyType = .Go
        loginToTop.active = false
        CHLogo.hidden=false
        welcomeLabel.hidden=false
        CHLogo.layer.borderColor = UIColor.whiteColor().CGColor
        CHLogo.layer.cornerRadius = 5
        CHLogo.layer.borderWidth = 1
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        dismiss = UITapGestureRecognizer(target: self, action: "touch:")
        view.addGestureRecognizer(dismiss)
        usernameField.backgroundColor = .whiteColor()
        usernameField.backgroundColor = .whiteColor()
        loginToTop.active = true
        CHLogo.hidden=true
        welcomeLabel.hidden=true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.placeholder == " Username" {
            println("hhh")
            passwordField.becomeFirstResponder()
        } else {
            loginToTop.active = false
            CHLogo.hidden=false
            welcomeLabel.hidden=false
            textField.resignFirstResponder()
            login(textField)
        }
        return true
    }
}