//
//  Report.swift
//  FinalAppIOS
//
//  Created by moshiko elkalay on 04/03/2020.
//  Copyright © 2020 moshiko. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class Expenditude {
    let expenditudeTitle : String
    let expenditudeSum : Double
    let expenditudeDate : String
    
     
     
    init(expenditudeTitle : String, expenditudeSum : Double, expenditudeDate : String) {
     
         self.expenditudeTitle = expenditudeTitle
         self.expenditudeSum = expenditudeSum
        self.expenditudeDate = expenditudeDate
        
         
     }
     
    
     
     init?(_ dictonary : [String:Any]) {
        guard let expenditudeTitle = dictonary["expenditudeTitle"] as? String,
              let expenditudeSum = dictonary["expenditudeSum"] as? Double,
              let expenditudeDate = dictonary["expenditudeDate"] as? String
        else {
            return nil
        }
         
        self.expenditudeTitle = expenditudeTitle
        self.expenditudeSum = expenditudeSum
        self.expenditudeDate = expenditudeDate
        
     }
     
     var dictonaryRepresentation : [String:Any] {
         return [
             "expenditudeTitle":expenditudeTitle,
             "expenditudeSum":expenditudeSum,
             "expenditudeDate":expenditudeDate
         ]
     }
         
         
}
