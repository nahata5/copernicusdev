//
//  SecondViewController.swift
//  Diabetes
//
//  Created by Jeet Patel on 2/18/15.
//  Copyright (c) 2015 Jeet Patel. All rights reserved.
//

import UIKit
class MedicineVC: UIViewController {
    @IBOutlet var medList: UITableView!
    @IBOutlet var DoctorApptView: UIView!
    @IBOutlet var LabApptView: UIView!
    
    @IBOutlet var drMonth: UILabel!
    @IBOutlet var drDate: UILabel!
    @IBOutlet var drTime: UILabel!
    @IBOutlet var labDate: UILabel!
    @IBOutlet var labMonth: UILabel!
    @IBOutlet var labtime: UILabel!
    
    func setUpNextAppts() {
        var fullTime = NSDateFormatter()
        fullTime.dateFormat = "MM/dd/yy hh:mm a"
        DoctorApptView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "selectDoctor"))
        drVisit.append(DoctorAppointment(date: fullTime.dateFromString("09/15/15 10:30 AM")!, name: "Exam", type: .Regular))
        labVist.append(LabVisit(date: fullTime.dateFromString("09/08/15 2:30 PM")!, lab: "Labcorp"))
        LabApptView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "selectLab"))
        setUpDrLabView()

    }
    
    func setUpDrLabView() {
        var monthGetter = NSDateFormatter()
        var dateGetter = NSDateFormatter()
        var timeGetter = NSDateFormatter()
        var fullTime = NSDateFormatter()
        fullTime.dateFormat = "MM/dd/yy hh:mm a"
        monthGetter.dateFormat = "MMM"
        dateGetter.dateFormat = "dd"
        timeGetter.dateFormat = "hh:mm a"

        var drDates = drVisit[0].date
        var labDates = labVist[0].date
        drMonth.text = monthGetter.stringFromDate(drDates)
        self.drDate.text = dateGetter.stringFromDate(drDates)
        drTime.text = timeGetter.stringFromDate(drDates)
        labMonth.text = monthGetter.stringFromDate(labDates)
        self.labDate.text = dateGetter.stringFromDate(labDates)
        labtime.text = timeGetter.stringFromDate(labDates)

    }
    func selectMed() {
        var e = storyboard!.instantiateViewControllerWithIdentifier("editEvent") as EditEvent
        e.type = "Medicine"
        navigationController!.pushViewController(e, animated: true)
    }
    func selectDoctor() {
        var e = storyboard!.instantiateViewControllerWithIdentifier("editEvent") as EditEvent
        e.type = "Doctor"
        e.item = drVisit[0]
        navigationController!.pushViewController(e, animated: true)
    }
    func selectLab() {
        var e = storyboard!.instantiateViewControllerWithIdentifier("editEvent") as EditEvent
        e.type = "Lab"
        e.item = labVist[0]
        navigationController!.pushViewController(e, animated: true)
    }

    var medTableDel = MedTable()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        medList.dataSource = medTableDel
        medList.delegate = medTableDel
        medList.reloadData()
        medList.layer.borderWidth = 1
        medList.layer.borderColor = UIColor.lightGrayColor().CGColor
        setUpNextAppts()
    }
    override func viewDidAppear(animated: Bool) {
        medList.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        println("appearing")
        setUpDrLabView()
    }
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.BlackOpaque
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

