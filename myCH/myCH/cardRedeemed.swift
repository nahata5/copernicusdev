//
//  cardRedeems.swift
//  myCH
//
//  Created by Jeet Patel on 3/28/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import Foundation
import UIKit

class cardRedeemed:UIViewController {
    @IBOutlet var giftCard: UIView!
    @IBOutlet var logo: UIImageView!
    @IBOutlet var congratulate: UILabel!
    @IBOutlet var ccNumber: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        giftCard.layer.cornerRadius = 30
        logo.layer.borderColor = UIColor.whiteColor().CGColor
        logo.layer.cornerRadius = 5
        logo.layer.borderWidth = 1
        ccNumber.adjustsFontSizeToFitWidth = true
        ccNumber.sizeThatFits(ccNumber.bounds.size)
        ccNumber.sizeToFit()
    }
    
    @IBAction func saveImage(sender: AnyObject) {
        //saveImages()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    func saveImages() {
        UIGraphicsBeginImageContext(giftCard.bounds.size)
        var s = UIGraphicsGetCurrentContext()
        giftCard.layer.renderInContext(s)
        var img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
    }
}