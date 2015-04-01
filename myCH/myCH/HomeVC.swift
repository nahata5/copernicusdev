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
    @IBOutlet var contentView: UIView!

    @IBAction func contactUS(sender: AnyObject) {
        println("ggggg")
        UIApplication.sharedApplication().openURL(NSURL(string: "mailto:support@copernicus-health.com")!)
    }
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
        completedBar.frame = CGRect(x: completedBar.frame.minX, y: completedBar.frame.minY, width: 0, height: completedBar.frame.height)
        UIView.animateWithDuration(1, animations: {
            self.completedBar.frame = CGRect(x: self.completedBar.frame.minX, y: self.completedBar.frame.minY, width: self.progressBar.frame.width*pctt, height: self.completedBar.frame.height)
            },completion: {(bool) in
        })

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Welcome.text = "Hello \(currentUser!.name)"
        setBar("89")
        //optionTable.layer.borderColor = UIColor.lightGrayColor().CGColor
        //optionTable.layer.borderWidth = 1
//        optionTable.layer.shadowColor = UIColor.darkGrayColor().CGColor
//        optionTable.layer.shadowOpacity = 1
//        optionTable.layer.shadowOffset = CGSize(width: 0, height: 10)
//     
        view.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.TopMargin, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 0))
        var s = (optionTable.sectionHeaderHeight * 3) + (optionTable.sectionFooterHeight) + (44*10)
        view.addConstraint(NSLayoutConstraint(item: optionTable, attribute: NSLayoutAttribute.Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: s))
        Welcome.numberOfLines = 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
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
        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                cell = tableView.dequeueReusableCellWithIdentifier("EditProfile") as UITableViewCell
            case 1:
                cell = tableView.dequeueReusableCellWithIdentifier("Linked") as UITableViewCell
            default:
                return cell
            }
        } else if indexPath.section == 2 {
            switch indexPath.row {
            case 0:
                cell = tableView.dequeueReusableCellWithIdentifier("about") as UITableViewCell
            case 1:
                cell = tableView.dequeueReusableCellWithIdentifier("contactUs") as UITableViewCell
            case 2:
                cell = tableView.dequeueReusableCellWithIdentifier("tandc") as UITableViewCell
            default:
                return cell
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 2
        } else if section == 2 {
            return 3
        }
        return 0
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell!.reuseIdentifier == "EditProfile" {
            var t = storyboard?.instantiateViewControllerWithIdentifier("edit") as editProfile
            navigationController?.showViewController(t, sender: self)
        }
        if cell?.reuseIdentifier == "contactUs"{
            UIApplication.sharedApplication().openURL(NSURL(string: "mailto:support@copernicus-health.com")!)
        }
    }
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = UIColor(red: 200/255, green: 241/255, blue: 255/255, alpha: 1)
        tableView.backgroundColor = UIColor.clearColor()
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Rewards"
        } else if section == 1 {
            return "Profile"
        } else if section == 2 {
            return "About"
        }
        return ""
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

}