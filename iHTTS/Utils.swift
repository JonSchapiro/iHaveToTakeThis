//
//  Utils.swift
//  iHTTS
//
//  Created by Jonathan Schapiro on 4/17/16.
//  Copyright © 2016 Jonathan Schapiro. All rights reserved.
//

import Foundation

class Utils {
    class func isValidPhoneNumber(phoneNumber:String) -> Bool {
        //a valid number is 12 digits long and contains only nymbers
        if phoneNumber.characters.count != 12 {
            return false
        }
        
        let tempPhoneNumber = phoneNumber.stringByReplacingOccurrencesOfString("-", withString: "")
        
        let badCharacters = NSCharacterSet.decimalDigitCharacterSet().invertedSet
        
        if tempPhoneNumber.rangeOfCharacterFromSet(badCharacters) == nil {
            print("Phone number is valid")
            return true
        } else {
            print("Phone number contained non-digit characters.")
            return false
        }

    }
    
    class func cleanPhoneNumber(dirtyNumber:String) -> String {
        //remove all spaces and add +1
        let tempPhoneNumber = dirtyNumber.stringByReplacingOccurrencesOfString("-", withString: "")
        let cleanNumber = "+1" + dirtyNumber.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        return cleanNumber
    }
    
    class func isValidCallerName(name:String?) -> Bool {
        if name?.characters.count == 0 {
            return false;
        }
        return true
    }
}
