//
//  user.swift
//  myCH
//
//  Created by Jeet Patel on 3/17/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit
class userProfile:NSObject, NSCoding {
    var name:String
    var address:String
    var city:String
    var state:String
    var zipcode:String
    var doctor:String
    var insurer:String
    var username:String
    var password:String
    var height:Double
    init(name:String,address:String,city:String,state:String, zipcode:String,doctor:String,insurer:String,username:String,password:String,height:Double){
        self.name = name
        self.address = address
        self.city = city
        self.state  = state
        self.zipcode  = zipcode
        self.doctor = doctor
        self.insurer = insurer
        self.username  = username
        self.password = password
        self.height = height
        super.init()
    }
    required init(coder aDecoder: NSCoder) {
        var a = aDecoder.decodeObjectForKey("user") as userProfile
        self.name = aDecoder.decodeObjectForKey("name") as String
        self.address = aDecoder.decodeObjectForKey("address") as String
        self.city = aDecoder.decodeObjectForKey("city") as String
        self.state = aDecoder.decodeObjectForKey("state") as String
        self.zipcode = aDecoder.decodeObjectForKey("zipcode") as String
        self.doctor = aDecoder.decodeObjectForKey("doctor") as String
        self.insurer = aDecoder.decodeObjectForKey("insurer") as String
        self.username = aDecoder.decodeObjectForKey("username") as String
        self.password = aDecoder.decodeObjectForKey("password") as String
        self.height = aDecoder.decodeObjectForKey("height") as Double
        super.init()
        
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self, forKey: "user")
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.address, forKey: "address")
        aCoder.encodeObject(self.city, forKey: "city")
        aCoder.encodeObject(self.state, forKey: "state")
        aCoder.encodeObject(self.zipcode, forKey: "zipcode")
        aCoder.encodeObject(self.doctor, forKey: "doctor")
        aCoder.encodeObject(self.insurer, forKey: "insurer")
        aCoder.encodeObject(self.username, forKey: "username")
        aCoder.encodeObject(self.password, forKey: "password")
        aCoder.encodeObject(self.height, forKey: "height")
    }
}
