//
//  verifyVC.swift
//  myCH
//
//  Created by Jeet Patel on 3/15/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit

class verifyVC:UIViewController, UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {

    @IBOutlet var summaryTable: UITableView!
    @IBOutlet var CodeField: UITextField!
    var dismiss = UITapGestureRecognizer()
    @IBAction func checkandRegister(sender: AnyObject) {
        if CodeField.text == "1234" {
            temporaryTrackResults.addToRecord()
            var root = self.navigationController!.parentViewController!
            self.navigationController?.popToRootViewControllerAnimated(true)
            var t = pointsView(View: root.view)
            t.presentPoints(root.view, mainText: "+150")
        } else {
            CodeField.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
        }
    }
    override func viewDidLoad() {
        summaryTable.delegate=self
        summaryTable.dataSource = self
        summaryTable.layer.borderColor = UIColor.lightGrayColor().CGColor
        summaryTable.layer.borderWidth = 0.5
        CodeField.keyboardType = .NumberPad
        CodeField.delegate = self
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.backgroundColor = UIColor.clearColor()
        view.addGestureRecognizer(dismiss)
        view.removeGestureRecognizer(dismiss)
        dismiss = UITapGestureRecognizer(target: self, action: "resign")
        view.addGestureRecognizer(dismiss)
    }
    func resign() {
        view.endEditing(true)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        resign()
        return true
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("hba1c") as UITableViewCell
            var value = (cell.viewWithTag(2) as UILabel)
            value.text = String(format:"%0.1f",temporaryTrackResults.HBA1C!)
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("hdl") as UITableViewCell
            var value = (cell.viewWithTag(2) as UILabel)
            value.text = String(format:"%0.1f",temporaryTrackResults.HDL!)
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("ldl") as UITableViewCell
            var value = (cell.viewWithTag(2) as UILabel)
            value.text = String(format:"%0.1f",temporaryTrackResults.LDL!)
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier("cholesterol") as UITableViewCell
            var value = (cell.viewWithTag(2) as UILabel)
            value.text = String(format:"%0.1f",temporaryTrackResults.cholesterol!)
        case 4:
            cell = tableView.dequeueReusableCellWithIdentifier("tag") as UITableViewCell
            var value = (cell.viewWithTag(2) as UILabel)
            value.text = String(format:"%0.1f",temporaryTrackResults.TAG!)
        case 5:
            cell = tableView.dequeueReusableCellWithIdentifier("weight") as UITableViewCell
            var value = (cell.viewWithTag(2) as UILabel)
            value.text = String(format:"%0.1f",temporaryTrackResults.weight)
        case 6:
            cell = tableView.dequeueReusableCellWithIdentifier("bp") as UITableViewCell
            var value = (cell.viewWithTag(2) as UILabel)
            value.text = "\(temporaryTrackResults.bp[0])/\(temporaryTrackResults.bp[1])"
        case 7:
            cell = tableView.dequeueReusableCellWithIdentifier("pulse") as UITableViewCell
            var value = (cell.viewWithTag(2) as UILabel)
            value.text = String(temporaryTrackResults.pulse)
        default:
            return cell
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
}