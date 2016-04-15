//
//  ViewController.swift
//  iHTTS
//
//  Created by Jonathan Schapiro on 4/15/16.
//  Copyright © 2016 Jonathan Schapiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var callerName: UITextField!

    @IBOutlet weak var callDelay: UISlider!
    
    @IBOutlet weak var repeatCall: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveCallInformation(sender: AnyObject) {
        print("Saving Call Information...")
        let myUserDefaults = NSUserDefaults.init(suiteName: "group.iHTTS")
        
        let name = self.callerName.text
        let delay = String(format:"%.0f",self.callDelay.value)
        let shouldRepeat = repeatCall.on ? "true" : "false"
        
        myUserDefaults?.setObject(name, forKey: "callerName")
        myUserDefaults?.setObject(delay, forKey: "callerDelay")
        myUserDefaults?.setObject(shouldRepeat, forKey: "repeatCall")
        
        myUserDefaults?.synchronize()
        
        print("Call information saved...")
    }
    

}

