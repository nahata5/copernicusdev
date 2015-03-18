//
//  VidQVC.swift
//  Diabetes
//
//  Created by Jeet Patel on 3/7/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit
/*
class VidQVC:UIViewController, UIWebViewDelegate {
    @IBOutlet var loadingInd: UIActivityIndicatorView!
    func webViewDidStartLoad(webView: UIWebView) {
        loadingInd.startAnimating()
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        loadingInd.stopAnimating()
    }
    @IBOutlet var submit: UIButton!
    @IBOutlet var questionView: UITableView!
    @IBOutlet var vidViewr: UIWebView!
    override func viewDidLoad() {
        submit.addTarget(questionDel, action: "submit", forControlEvents: .TouchUpInside)
        view.addConstraint(NSLayoutConstraint(item: vidViewr, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: view.frame.width*CGFloat(pow(ratio,-1))))
        vidViewr.delegate = self
        vidViewr.loadHTMLString("<style>body,html,iframe{margin:0;padding:0; border-style:none;}</style> <iframe webkit-playsinline width=\"\(view.frame.size.width)\" height=\"\(view.frame.size.width*(315.00/560.00))\" src=\"\(url)\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
        self.automaticallyAdjustsScrollViewInsets = false
        questionView.dataSource = questionDel
        questionView.delegate = questionDel
        questionView.backgroundView?.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets=false
        questionDel.askQuestion(questionView, question: "What is Diabetes?", options: ["Low Blood Glucose", "Overproduction of Insulin", "Underproduction of Insulin, leading to high glucose", "High Cholesterol"], correctIndex: 2)
        //view.addConstraint(NSLayoutConstraint(item: s, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0))
        //view.addConstraint(NSLayoutConstraint(item: s, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
    }
    
}
*/
