//
//  ViewController.swift
//  iHTTS
//
//  Created by Jonathan Schapiro on 4/15/16.
//  Copyright © 2016 Jonathan Schapiro. All rights reserved.
//

import UIKit
import AddressBook

class ViewController: UIViewController {
    
    @IBOutlet weak var callerName: UITextField!

    @IBOutlet weak var callDelay: UISlider!
    
    @IBOutlet weak var repeatCall: UISwitch!
    
    @IBOutlet weak var myNumber: UITextField!
    
    //address book vars
    var authDone:Bool = false
    var adbk:ABAddressBookRef?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.setupAddressBook()
    }
    
    func setupAddressBook() {
        if !self.authDone {
            self.authDone = true
            let stat = ABAddressBookGetAuthorizationStatus()
            switch stat {
            case .Denied, .Restricted:
                print("no access")
            case .Authorized, .NotDetermined:
                var err : Unmanaged<CFError>? = nil
                var adbk : ABAddressBook? = ABAddressBookCreateWithOptions(nil, &err).takeRetainedValue()
                if adbk == nil {
                    print(err)
                    return
                }
                ABAddressBookRequestAccessWithCompletion(adbk) {
                    (granted:Bool, err:CFError!) in
                    if granted {
                        self.adbk = adbk
                    } else {
                        print(err)
                    }//if
                }//ABAddressBookReqeustAccessWithCompletion
            }//case
        }//if
    }
    
    @IBAction func saveCallInformation(sender: AnyObject) {
        print("Saving Call Information...")
        
        let myUserDefaults = NSUserDefaults.init(suiteName: "group.iHTTS")
        var shouldCreateContact = false
        
        let name = self.callerName.text
        let myNumber:String?
        
        if Utils.isValidPhoneNumber(self.myNumber.text!){
            
            myNumber = Utils.cleanPhoneNumber(self.myNumber.text!)
            
        } else {
            
           let invalidNumberAlert =  UIAlertView(title: "Uh Oh!", message: "Please enter a valid phone number...", delegate: nil, cancelButtonTitle: "OK")
            invalidNumberAlert.show()
            
            return
        }
        
        if !Utils.isValidCallerName(name) {
            
            let invalidNameAlert = UIAlertView(title: "Uh Oh!", message: "Please enter a valid caller name...", delegate: nil, cancelButtonTitle: "OK")
            invalidNameAlert.show()
            
            return
        }
        
        if myUserDefaults?.stringForKey("name") == nil {
            shouldCreateContact = true
        }
        
        let delay = String(format:"%.0f",self.callDelay.value)
        let shouldRepeat = repeatCall.on ? "true" : "false"
        
        myUserDefaults?.setObject(myNumber, forKey: "myNumber")
        myUserDefaults?.setObject(name, forKey: "callerName")
        myUserDefaults?.setObject(delay, forKey: "callerDelay")
        myUserDefaults?.setObject(shouldRepeat, forKey: "repeatCall")
        
        myUserDefaults?.synchronize()
        
        self.clearTextFields()
        
        if shouldCreateContact {
            self.createNewContact(name!)
        }
        
        print("Call information saved...")
    }
    
    func clearTextFields() {
        
        self.callerName.text = ""
        self.myNumber.text = ""
        
    }
    
    func createNewContact(name:String) {
        let newContact:ABRecordRef! = ABPersonCreate().takeRetainedValue()
        let newFirstName:NSString = name
        var success:Bool = false
        
        
        
        //Updated to work in Xcode 6.1
        var error: Unmanaged<CFErrorRef>? = nil
        //Updated to error to &error so the code builds in Xcode 6.1
        success = ABRecordSetValue(newContact, kABPersonFirstNameProperty, newFirstName, &error)
        print("setting last name was successful? \(success)")
        success = ABAddressBookAddRecord(adbk, newContact, &error)
        print("Adbk addRecord successful? \(success)")
        success = ABAddressBookSave(adbk, &error)
        print("Adbk Save successful? \(success)")
    }

}

