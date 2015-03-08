//
//  VidQVC.swift
//  Diabetes
//
//  Created by Jeet Patel on 3/7/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit
class VidQVC:UIViewController, UIWebViewDelegate {
    
    @IBOutlet var questionVieww: QuestionView!
    var url:NSString = "https://www.youtube.com/embed/xWJdSIiFxM4?t=100?rel=0&amp;showinfo=0?feature=player_detailpage&playsinline=1"
    var ratio = 560.00/315.00
    @IBOutlet var vidViewr: UIWebView!
    override func viewDidLoad() {
        questionVieww.setupOptions(4, text: ["A1C","Glucose","Fasting Plasma Glucose","Postprandial Plasma Glucose"], correctIndex: 2)
        questionVieww.setTitle("What is the level of glucose measured right before you wake up?")
        questionVieww.label.sizeToFit()
        questionVieww.label.minimumScaleFactor = 0.7
        questionVieww.label.adjustsFontSizeToFitWidth = true
        questionVieww.label.numberOfLines = 2
        vidViewr.allowsInlineMediaPlayback = true
        vidViewr.delegate = self
        vidViewr.loadHTMLString("<style>body,html,iframe{margin:0;padding:0; border-style:none;}</style> <iframe webkit-playsinline width=\"\(view.frame.size.width)\" height=\"\(view.frame.size.width*(315.00/560.00))\" src=\"\(url)\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
        self.automaticallyAdjustsScrollViewInsets = false
        vidViewr.scrollView.scrollEnabled = false
        vidViewr.scrollView.backgroundColor = UIColor.whiteColor()
        var s = MCOption(text: "hello", Correct: false, superr: view)
        //view.addConstraint(NSLayoutConstraint(item: s, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0))
        //view.addConstraint(NSLayoutConstraint(item: s, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
    }
    
}