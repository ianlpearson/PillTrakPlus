//
//  ViewController.swift
//  PillTrak+
//
//  Created by Nathan Loew on 10/28/17.
//  Copyright © 2017 Nathan Loew. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    
    var hour = 12
    var min = 15
    var ampm = 0
    var delayMed1 = 0
    var delayMed2 = 0
    var hasTaken = false
    var snoozed = false
    var skipped = false
    
    
    let myNotification = Notification.Name(rawValue: "MyNotification")
    
    @IBOutlet weak var zyrtecTime: UIDatePicker!
    @IBOutlet weak var metaTime: UIDatePicker!
    @IBOutlet weak var timeDisplay: UILabel!
    @IBOutlet weak var medList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let nc = NotificationCenter.default
        nc.addObserver(forName: myNotification, object: nil, queue: nil, using: catchNotification)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func pressTime(_ sender: Any) {

        
        min = min + 15
        if(min==60){
            hour=hour+1
            if(hour==12){
                ampm = ampm+1
                if(ampm==2){
                    ampm=0
                }
            }
            if(hour==13){
                hour=1
            }
            min=0
        }
        
        if(min==0){
            if(ampm==0){
            timeDisplay.text = String(hour) + ":00am"
            } else if(ampm==1){
                timeDisplay.text = String(hour) + ":00pm"
            }
        } else {
            if(ampm==0){
            timeDisplay.text = String(hour) + ":" + String(min) + "am"
            } else if(ampm==1){
                timeDisplay.text = String(hour) + ":" + String(min) + "pm"
            }
        }
        
        if(getTimeFromDatePicker(datePicker: zyrtecTime)=="\(hour):\(min)" && ampm==0){
            delayMed1=1
        }
        if(getTimeFromDatePicker(datePicker: metaTime)=="\(hour):\(min)" && ampm==1){
            delayMed2=1
        }
        if(delayMed1>0){
            if(delayMed1 > 4){

                let nc = NotificationCenter.default
                nc.post(name: myNotification, object: nil, userInfo: ["message":"Final reminder to take ","medication":"Focalin","final":"yes"])
                
             /*   if(hasTaken){
                    print("dose of focalin taken at \(hour):\(min)")
                    hasTaken = false
                } else if(skipped){
                    print("dose of focalin skipped at \(hour):\(min)")
                    skipped = false
                }
                delayMed1=0*/
                
            }
            else {
                let nc = NotificationCenter.default
                nc.post(name: myNotification, object: nil, userInfo: ["message":"Reminder to take ","medication":"Focalin","final":"no"])
                
                
               /* if(hasTaken){
                    print("dose of focalin taken at \(hour):\(min)")
                    hasTaken=false
                delayMed1=0
                } else if(snoozed){
                    print("dose of focalin snoozed at \(hour):\(min)")
                    skipped=false
                    delayMed1=delayMed1 + 1
                }*/
            
            
            }
        }
        if(delayMed2>0){
            if(delayMed2>4){
                let nc = NotificationCenter.default
                nc.addObserver(forName: myNotification, object: nil, queue: nil, using: catchNotification(notification:))

                nc.post(name: myNotification, object: nil, userInfo: ["message":"Final reminder to take ","medication":"Metoprolol","final":"yes"])
                
                /*if(hasTaken){
                    print("dose of metoprolol taken at \(hour):\(min)")
                    hasTaken = false
                } else if(skipped){
                    print("dose of metoprolol skipped at \(hour):\(min)")
                    skipped = false
                }*/
             
                delayMed2=0
            } else {
                let nc = NotificationCenter.default
                nc.post(name: myNotification, object: nil, userInfo: ["message":"Reminder to take ","medication":"Metoprolol","final":"no"])
              /*  if(hasTaken){
                    delayMed2=0
                    print("dose of metoprolol taken at \(hour):\(min)")
                    hasTaken=false
                } else if(snoozed) {
                    print("dose of metoprolol snoozed at \(hour):\(min)")
                    snoozed=false
                    delayMed2=delayMed2 + 1
                }*/
            }
        }

        
    }
    func catchNotification(notification:Notification) -> Void {
        print("Catch notification")
        
        guard let userInfo = notification.userInfo,
            let message  = userInfo["message"] as? String,
            let med     = userInfo["medication"]    as? String,
            let final = userInfo["final"] as? String else {
                print("No userInfo found in notification")
                return
        }
        
        let alert = UIAlertController(title: "Notification!",
                                      message:"\(message)\(med)",
            preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in self.hasTaken=true}))
        if(final=="no"){
            alert.addAction(UIAlertAction(title: "Remind me later", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in self.snoozed=true}))
        } else {
            alert.addAction(UIAlertAction(title: "Skip this dose", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in self.skipped=true}))
        }
        self.present(alert, animated: true, completion: self.assortedStuff)

        
    }
    
    func getTimeFromDatePicker(datePicker:UIDatePicker) -> String{
        let date = datePicker.date
        let calendar = NSCalendar.current
        let comp = calendar.dateComponents([.hour, .minute, .era], from: date)
        
    
        return "\(comp.hour ?? -1):\(comp.minute ?? -1)"
    }

    func assortedStuff() -> Void{
        if(delayMed1>0){
            if(delayMed1 > 4){

                if(hasTaken){
                    print("dose of focalin taken at \(hour):\(min)")
                    hasTaken = false
                } else if(skipped){
                    print("dose of focalin skipped at \(hour):\(min)")
                    skipped = false
                }
                delayMed1=0
                
            }
            else {

                if(hasTaken){
                    print("dose of focalin taken at \(hour):\(min)")
                    hasTaken=false
                    delayMed1=0
                } else if(snoozed){
                    print("dose of focalin snoozed at \(hour):\(min)")
                    skipped=false
                    delayMed1=delayMed1 + 1
                }
                
                
            }
        }
        if(delayMed2>0){
            if(delayMed2>4){
              
                
                if(hasTaken){
                    print("dose of metoprolol taken at \(hour):\(min)")
                    hasTaken = false
                } else if(skipped){
                    print("dose of metoprolol skipped at \(hour):\(min)")
                    skipped = false
                }
                
                delayMed2=0
            } else {

                if(hasTaken){
                    delayMed2=0
                    print("dose of metoprolol taken at \(hour):\(min)")
                    hasTaken=false
                } else if(snoozed) {
                    print("dose of metoprolol snoozed at \(hour):\(min)")
                    snoozed=false
                    delayMed2=delayMed2 + 1
                }
            }
        }
    }
    
    

}

