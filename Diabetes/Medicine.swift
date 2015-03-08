//
//  Medicine.swift
//  Diabetes
//
//  Created by Jeet Patel on 2/19/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit
enum days{
    case Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday
}
class Medicine:NSObject {

    var name:String
    var image:UIImage
    var numberOfPills:Int
    var refillsRemaining:Double
    var freq:[days] = []
    required init(coder:NSCoder) {
        fatalError("Error:\(coder)")
    }
    init(names:String, images:UIImage?, pills:String,refills:String) {
        name = names
        if(images == nil) {
            self.image = UIImage(named: "Pill")!
        } else {
            self.image = images!
        }
        numberOfPills = pills.toInt()!
        refillsRemaining = NSString(string: refills).doubleValue
    }

}