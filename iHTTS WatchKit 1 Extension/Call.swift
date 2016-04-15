//
//  Call.swift
//  iHTTS
//
//  Created by Jonathan Schapiro on 4/15/16.
//  Copyright © 2016 Jonathan Schapiro. All rights reserved.
//

import Foundation

class Call {
    var callerName:String?
    var callDelay:String?
    var callRepeat:String?
    
    init(callerName:String?,callDelay:String?,callRepeat:String?){
        self.callerName = callerName
        self.callDelay = callDelay
        self.callRepeat = callRepeat
    }
    
    func makePhoneCall () -> Void {
        //make http request to node server with params
        print("requesting phone call from server... with params:")
        print("callerName:",self.callerName)
        print("callDelay:",self.callDelay)
        print("callRepeat",self.callRepeat)
    }
}