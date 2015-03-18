//
//  LoginBackEnd.swift
//  myCH
//
//  Created by Jeet Patel on 3/17/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit

var userdefaults = NSUserDefaults.standardUserDefaults()
var a = userProfile(name: "Copernicus Health", address: "1 Main St", city: "New Brunswick", state: "NJ", zipcode: "08854", doctor: "Doctor Doe", insurer: "", username: "myCH", password: "copernicusdev", height: 55.5)
var loginBE = LoginBackEnd()
var currentUser:userProfile?

class LoginBackEnd {
    func setUpDB() {
        if let b = userdefaults.objectForKey("currentUser") as? NSData {
            var c = NSKeyedUnarchiver.unarchiveObjectWithData(b) as userProfile
            currentUser = c
        } else {
            if let c = userdefaults.objectForKey("users") as? NSData {
            
            } else {
                var users:[userProfile] = [a]
                var userData = NSKeyedArchiver.archivedDataWithRootObject(users) as NSData
                userdefaults.setObject(userData, forKey: "users")
            }
        }
        userdefaults.synchronize()
    }
    func saveUser(user:userProfile,oldUser:userProfile){
        var users = NSKeyedUnarchiver.unarchiveObjectWithData(userdefaults.valueForKeyPath("users") as NSData) as [userProfile]
        var s = find(users, user)!
        users[s] = user
        var data = NSKeyedArchiver.archivedDataWithRootObject(users) as NSData
        userdefaults.setObject(data, forKey: "users")
        userdefaults.synchronize()

    }
    func login(username:String,password:String) -> Bool {
        var users = NSKeyedUnarchiver.unarchiveObjectWithData(userdefaults.valueForKeyPath("users") as NSData) as [userProfile]
        for user in users {
            if user.username.lowercaseString == username.lowercaseString && user.password == password {
                print(find(users, user))
                var data = NSKeyedArchiver.archivedDataWithRootObject(user)
                userdefaults.setObject(data, forKey: "currentUser")
                currentUser = user
                println("\(currentUser?.username)")
                return true
            }
        }
        return false
    }
    func register(newUser:userProfile) {
        var users = NSKeyedUnarchiver.unarchiveObjectWithData(userdefaults.valueForKeyPath("users") as NSData) as [userProfile]
        users.append(newUser)
        var data = NSKeyedArchiver.archivedDataWithRootObject(users) as NSData
        userdefaults.setObject(data, forKey: "users")
        userdefaults.synchronize()
    }
}