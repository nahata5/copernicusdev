//
//  FirstViewController.swift
//  Diabetes
//
//  Created by Jeet Patel on 2/18/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import UIKit

class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var progressBar: UIView!
    @IBOutlet var percentLabel: UILabel!

    @IBOutlet var image: UIImageView!
    @IBOutlet var completedBar: UIView!
    @IBOutlet var Welcome: UILabel!
    @IBOutlet var optionTable: UITableView!
    @IBOutlet var tabButto: UITabBarItem!
    var barPercent = NSLayoutConstraint()
    @IBAction func logout(sender:AnyObject) {
        userdefaults.setBool(false, forKey: "isLoggedIn")
        userdefaults.removeObjectForKey("currentUser")
        currentUser = nil
        userdefaults.synchronize()
        optionTable.sectionIndexBackgroundColor=UIColor.whiteColor()
        var s = storyboard?.instantiateViewControllerWithIdentifier("login") as UIViewController
        self.presentViewController(s, animated: true, completion: nil)
    }
    func setBar(percent:String) {
        view.addConstraint(barPercent)
        view.removeConstraint(barPercent)
        var pct = percent.toInt()!
        var pctt = CGFloat(Double(pct)/100.00)
        percentLabel.text = "500 points"
        print(pctt)
        barPercent = NSLayoutConstraint(item: progressBar, attribute: .Width, relatedBy: .Equal, toItem: completedBar, attribute: .Width, multiplier: 1/pctt, constant: 0)
        view.addConstraint(barPercent)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Welcome.text = "Hello \(currentUser!.name)"
        setBar("50")
        Welcome.numberOfLines = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("cashout") as UITableViewCell
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("marketplace") as UITableViewCell
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("EditProfile") as UITableViewCell
        default:
            return cell
        }
        if indexPath.section == 1 {
            cell = tableView.dequeueReusableCellWithIdentifier("EditProfile") as UITableViewCell
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        view.addConstraint(NSLayoutConstraint(item: optionTable, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: ((44*6))))
        if section == 0 {
            return 2
        } else {
            return 1
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell!.reuseIdentifier == "EditProfile" {
            var t = storyboard?.instantiateViewControllerWithIdentifier("edit") as editProfile
            navigationController?.showViewController(t, sender: self)
        }
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Points"
        } else {
            return "Profile"
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
}

