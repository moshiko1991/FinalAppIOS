//
//  ExpenditudeDetailes.swift
//  FinalAppIOS
//
//  Created by moshiko elkalay on 19/03/2020.
//  Copyright © 2020 moshiko. All rights reserved.
//

import Foundation


struct ExpenditudeDetails {
    let expenditudeTitle : String
    let expenditudeSum : String
    let expenditudeDate : String
    
    
    init(expenditudeTitle : String, expenditudeSum : String, expenditudeDate : String){
        self.expenditudeTitle = expenditudeTitle
        self.expenditudeSum = expenditudeSum
        self.expenditudeDate = expenditudeDate
       
    }
    
    init?(_ dictonary : [String:Any]) {
        guard let expenditudeTitle = dictonary["expenditudeTitle"] as? String,
            let expenditudeSum = dictonary["expenditudeSum"] as? String,
            let expenditudeDate = dictonary["expenditudeDate"] as? String
        else {
                return nil
        }
        
        self.expenditudeTitle = expenditudeTitle
        self.expenditudeSum = expenditudeSum
        self.expenditudeDate = expenditudeDate
    }
    
     var dictionaryRepresentation : [String:Any] {
           return [
               "expenditudeTitle":expenditudeTitle,
               "expenditudeSum":expenditudeSum,
               "expenditudeDate":expenditudeDate,
               
           ]
       }
}
