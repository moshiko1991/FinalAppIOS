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

class Report {
    let reportId : String
    let cash : Double
    let creditCard : Double
    let reportDate : String
     
     
    init(reportId : String, cash : Double, creditCard : Double, reportDate : String) {
     
         self.reportId = reportId
         self.cash = cash
         self.creditCard = creditCard
         self.reportDate = reportDate
         
     }
     
    
     
     init?(_ dictonary : [String:Any]) {
         guard let reportId = dictonary["reportId"] as? String,
               let cash = dictonary["cash"] as? Double,
               let creditCard = dictonary["creditCard"] as? Double,
               let reportDate = dictonary["reportDate"] as? String
            else {
         return nil
         }
         
         self.reportId = reportId
         self.cash = cash
         self.creditCard = creditCard
         self.reportDate = reportDate
        
         
     }
     
     var dictonaryRepresentation : [String:Any] {
         return [
             "reportId":reportId,
             "cash":cash,
             "creditCard":creditCard,
             "reportDate":reportDate
             
         ]
     }
         
         
}
