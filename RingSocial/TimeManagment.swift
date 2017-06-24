//
//  TimeManagment.swift
//  RingSocial
//
//  Created by Dakshesh patel on 6/23/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import Foundation
import UIKit


class TimeManagment {
    
    var date1  = Date()
    var date2 : Date!
    
    
    init( date : String) {
        
        let convertToInt = Int(date)!
        self.date2 = NSDate(timeIntervalSince1970: TimeInterval(convertToInt/1000)) as Date
        
        
    }
    
    func getTimeFormate() -> String {
        
        var newdate : String!
        if(date1.seconds(from: date2) < 60) {
            newdate = "just now"
            
        } else if (date1.minutes(from: date2) < 60) {
            newdate = (String) (date1.minutes(from: date2)) + "m"
        } else if (date1.hours(from: date2) < 24) {
            newdate = (String) (date1.hours(from: date2)) + "hr"
        } else if (date1.days(from: date2) < 1) {
            newdate = "Today"
        } else if (date1.days(from: date2) < 2) {
            newdate = "Yesterday"
        } else if (date1.days(from: date2) < 3) {
            newdate = "3days"
        }else if (date1.days(from: date2) < 4) {
            newdate = "4days"
        }else {
            
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            newdate = formatter.string(from: date2 as Date)
        }
        
        return newdate
    }
    
}
