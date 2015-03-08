//
//  FirstViewController.swift
//  Diabetes
//
//  Created by Jeet Patel on 2/18/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet var contentView: UIView!
    @IBOutlet var buttonView: UIView!
    @IBOutlet var tabButto: UITabBarItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        buttonView.layer.contents = UIImage(named: "Box.png")!.CGImage
        println("\(buttonView.frame.width),\(buttonView.frame.height)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

