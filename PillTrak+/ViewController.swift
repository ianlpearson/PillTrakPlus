//
//  ViewController.swift
//  PillTrak+
//
//  Created by Ian Pearson on 10/28/17.
//  Copyright © 2017 Ian Pearson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressAdd(_ sender: Any) {
        // Bring up the screen to add a new cell to the medList table, and then add it
    }
    
    @IBAction func pressTime(_ sender: Any) {
        // progress the simulated time by an hour or so to go to the next time
        
        //for the sake of the demo, we can just have it check if the time value matches the time of any med notifications, and then call the notification function here
    }

    @IBOutlet weak var medList: UITableView!
    
    

}

