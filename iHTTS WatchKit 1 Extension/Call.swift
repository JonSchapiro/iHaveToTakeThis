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
        
        let url = "http://localhost:3000/api/call/" + self.callerName!
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "GET"
        let postString = "callDelay=" + self.callDelay! + "&callRepeat=" + self.callRepeat!
        //request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
        }
        task.resume()
        
    }
}