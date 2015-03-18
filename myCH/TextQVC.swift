//
//  TextQVC.swift
//  Diabetes
//
//  Created by Jeet Patel on 3/7/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit

var textQDel = questionView()
class TextQVC:UIViewController {
    @IBOutlet var textView: UITextView!
    @IBOutlet var URLButton: UIButton!
    var urlArticle = ""
    @IBOutlet var question: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.contentOffset = CGPointZero
        textView.contentInset = UIEdgeInsetsZero
        textView.setTranslatesAutoresizingMaskIntoConstraints(false)
        question.delegate = textQDel
        question.dataSource = textQDel
    }
}