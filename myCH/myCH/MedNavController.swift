//
//  NavController.swift
//  Diabetes
//
//  Created by Jeet Patel on 2/18/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit

class MedNavController:UINavigationController {
    @IBOutlet var navbar: UINavigationBar!
    override func viewDidLoad() {
            //= UIColor.redColor()
        self.navigationBar.titleTextAttributes = [UIColor.whiteColor():NSForegroundColorAttributeName]
    }
    override func didReceiveMemoryWarning() {
    }
    func done() {
        self.presentViewController(NewMedVC(), animated: true, completion: nil)
    }
}