//
//  LabPage.swift
//  myCH
//
//  Created by Jeet Patel on 3/15/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit
var labResultsDel = LabDelegate()
class LabResultsVC:UIViewController {
    @IBOutlet var labTable: UITableView!
    @IBAction func moveToVerify(sender: AnyObject) {
        if labResultsDel.submit() {
            var verify = storyboard!.instantiateViewControllerWithIdentifier("verify") as UIViewController
            self.navigationController?.pushViewController(verify, animated: true)
        }
    }
    override func viewDidLoad() {
        labTable.delegate = labResultsDel
        labTable.dataSource = labResultsDel
        labTable.layer.borderColor = UIColor.lightGrayColor().CGColor
        labTable.layer.borderWidth = 0.5
    }

}