//
//  TrackVC.swift
//  Diabetes
//
//  Created by Jeet Patel on 3/7/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit
class LearnVC:UIViewController,UIWebViewDelegate {
    @IBOutlet var TextQues: UIView!
    @IBOutlet var VidQues: UIView!
    @IBOutlet var youtubeVid: UIWebView!
    @IBOutlet var vidQTable: UITableView!
    @IBOutlet var VidTextSwitch: UISegmentedControl!
    @IBOutlet var loading: UIActivityIndicatorView!
    @IBOutlet var textQTable: UITableView!
    var vidTableDel = questionView()
    var txtTableDel = questionView()
    @IBAction func segment(sender: AnyObject) {
        var s = sender as UISegmentedControl
        if s.selectedSegmentIndex == 1 {
            VidQues.hidden = false
            TextQues.hidden = true
            webView.start(youtubeVid, width: view.frame.width, url: "https://www.youtube.com/embed/xWJdSIiFxM4?t=100?rel=0&amp;showinfo=0?feature=player_detailpage&playsinline=1")
        } else {
            TextQues.hidden = false
            VidQues.hidden = true
            youtubeVid.stringByEvaluatingJavaScriptFromString("var videos = document.querySelectorAll(\"video\"); for (var i = videos.length - 1; i >= 0; i--) { videos[i].pause(); };")
            youtubeVid.stopLoading()
        }
    }
    @IBAction func submit(sender: AnyObject) {
        var send = sender as UIButton
        if VidTextSwitch.selectedSegmentIndex == 1 {
            vidTableDel.submit()
        } else {
            txtTableDel.submit()
        }
    }
    
    override func viewDidLoad(){
        vidQTable.dataSource = vidTableDel
        vidQTable.delegate = vidTableDel
        textQTable.dataSource = textQDel
        textQTable.delegate = textQDel
        youtubeVid.delegate=self
        vidTableDel.askQuestion(vidQTable, question: "What is Diabetes?", options: ["Low Blood Glucose", "Overproduction of Insulin", "Underproduction of Insulin, leading to high glucose", "High Cholesterol"], correctIndex: 2)
        textQDel.askQuestion(vidQTable, question: "What is Diabetes?", options: ["Low Blood Glucose", "Overproduction of Insulin", "Underproduction of Insulin, leading to high glucose", "High Cholesterol"], correctIndex: 2)
        view.addConstraint(NSLayoutConstraint(item: youtubeVid, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: view.frame.width*(315.00/560.00)))
        view.addConstraint(NSLayoutConstraint(item: youtubeVid, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: view.frame.width*(315.00/560.00)))
        self.automaticallyAdjustsScrollViewInsets = false
    }
    func webViewDidStartLoad(webView: UIWebView) {
        view.bringSubviewToFront(loading)
        loading.startAnimating()
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        loading.stopAnimating()
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

class webView:UIWebView {
    var url:NSString = "https://www.youtube.com/embed/xWJdSIiFxM4?t=100?rel=0&amp;showinfo=0?feature=player_detailpage&playsinline=1"
    var ratio = 560.00/315.00
    override init() {
        super.init(frame: CGRectZero)
        self.superview?.frame
        self.scrollView.scrollEnabled = false
        self.scrollView.backgroundColor = UIColor.whiteColor()
        self.loadHTMLString("<style>body,html,iframe{margin:0;padding:0; border-style:none;}</style> <iframe webkit-playsinline id=\"video\" \"width=\"\(self.superview!.frame.size.width)\" height=\"\(self.superview!.frame.size.width*(315.00/560.00))\" src=\"\(url)\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
        self.allowsInlineMediaPlayback = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    class func start(view:UIWebView, width:CGFloat, url:String) {
        view.superview?.frame
        view.scrollView.scrollEnabled = false
        view.scrollView.backgroundColor = UIColor.whiteColor()
        view.loadHTMLString("<style>body,html,iframe{margin:0;padding:0; border-style:none;}</style> <iframe id=\"video\" webkit-playsinline width=\"\(width)\" height=\"\(width*(315.00/560.00))\" src=\"\(url)\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
        view.allowsInlineMediaPlayback = true
    }
    
}