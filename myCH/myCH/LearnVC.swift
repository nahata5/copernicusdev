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
    @IBOutlet var textView: UITextView!
    @IBOutlet var TextQues: UIView!
    @IBOutlet var VidQues: UIView!
    @IBOutlet var youtubeVid: UIWebView!
    @IBOutlet var vidQTable: UITableView!
    @IBOutlet var VidTextSwitch: UISegmentedControl!
    @IBOutlet var loading: UIActivityIndicatorView!
    @IBOutlet var textQTable: UITableView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    var vidTableDel = questionView()
    var txtTableDel = txtQuestionView()
    @IBAction func segment(sender: AnyObject) {
        var s = sender as UISegmentedControl
        if s.selectedSegmentIndex == 1 {
            VidQues.hidden = false
            TextQues.hidden = true
            youtubeVid.hidden = false
            webView.start(youtubeVid, width: view.frame.width, url: "https://www.youtube.com/embed/rgNf8nsXA0Q?t=100?rel=0&amp;showinfo=0?feature=player_detailpage&playsinline=1")
        } else {
            TextQues.hidden = false
            TextQues.backgroundColor = .whiteColor()
            VidQues.hidden = true
            youtubeVid.hidden = true
            youtubeVid.stringByEvaluatingJavaScriptFromString("var videos = document.querySelectorAll(\"video\"); for (var i = videos.length - 1; i >= 0; i--) { videos[i].pause(); };")
            youtubeVid.stopLoading()
            youtubeVid.loadHTMLString("", baseURL: nil)
        }
    }
    @IBAction func openSource(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.cdc.gov/diabetes/living/problems.html")!)
    }
    @IBAction func submit(sender: AnyObject) {
        var send = sender as UIButton
        if VidTextSwitch.selectedSegmentIndex == 1 {
            if vidTableDel.submit() {
                var t = pointsView(View: VidQues)
                t.presentPoints(VidQues, mainText: "+30")
            }
        } else {
            if txtTableDel.submit() {
                var t = pointsView(View: view)
                t.presentPoints(view, mainText: "+30")
            }
        }
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(true)
        youtubeVid.loadHTMLString("", baseURL: nil)
    }
    override func viewDidAppear(animated: Bool) {
        if segmentedControl.selectedSegmentIndex == 1{
            VidQues.hidden = false
            TextQues.hidden = true
            webView.start(youtubeVid, width: view.frame.width, url: "https://www.youtube.com/embed/rgNf8nsXA0Q?rel=0&amp;controls=0&amp;showinfo=0")
        }
    }
    override func viewDidLoad(){
        vidQTable.dataSource = vidTableDel
        vidQTable.delegate = vidTableDel
        textQTable.dataSource = txtTableDel
        textQTable.delegate = txtTableDel
        youtubeVid.delegate=self
        youtubeVid.hidden = true
        vidTableDel.askQuestion(vidQTable, question: "______________ can injure nerve fibers throughout your body", options: ["High Blood Sugar", "Low Blood Sugar", "HDL Cholesterol", "Too much exercise"], correctIndex: 0)
        txtTableDel.askQuestion(textQTable, question: "To protect your heart and blood vessels, you should _________.", options: ["Smoke tobacco", "Eat fast food", "Get physical activity", "Forget to check your blood pressure"], correctIndex: 2)
        youtubeVid.backgroundColor = .clearColor()
        view.addConstraint(NSLayoutConstraint(item: youtubeVid, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: view.frame.width*(315.00/560.00)))
        view.addConstraint(NSLayoutConstraint(item: youtubeVid, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: view.frame.width*(315.00/560.00)))
        self.automaticallyAdjustsScrollViewInsets = false
        TextQues.backgroundColor = .whiteColor()
        textView.layer.borderColor = UIColor.lightGrayColor().CGColor
        textView.layer.borderWidth = 0.5
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
        self.loadHTMLString("<style>body,html,iframe{margin:0;padding:0; border-style:none;}</style> <iframe webkit-playsinline id=\"video\" \"width=\"\(self.superview!.frame.size.width)\" height=\"\(self.superview!.frame.size.width*(315.00/560.00))\" src=\"\(url)\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
        self.allowsInlineMediaPlayback = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    class func start(view:UIWebView, width:CGFloat, url:String) {
        view.scrollView.scrollEnabled = false
        view.loadHTMLString("<style>body,html,iframe{margin:0;padding:0; border-style:none;}</style> <iframe id=\"video\" webkit-playsinline width=\"\(width)\" height=\"\(width*(315.00/560.00))\" src=\"\(url)\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
        view.allowsInlineMediaPlayback = true
    }
}
