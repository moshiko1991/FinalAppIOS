//
//  ReportDetails.swift
//  FinalAppIOS
//
//  Created by moshiko elkalay on 11/03/2020.
//  Copyright © 2020 moshiko. All rights reserved.
//

import Foundation

struct ReportDetails {
    let reportId : String
    let reportCash : String
    let reportCreditCard : String
    let reportDate : String
    
    init(reportId : String, reportCash : String, reportCredirCard : String, reportDate : String){
        self.reportId = reportId
        self.reportCash = reportCash
        self.reportCreditCard = reportCredirCard
        self.reportDate = reportDate
    }
    
    init?(_ dictonary : [String:Any]) {
        guard let reportId = dictonary["reportId"] as? String,
            let reportCash = dictonary["reportCash"] as? String,
            let reportCreditCard = dictonary["reportCreditCard"] as? String,
            let reportDate = dictonary["reportDate"] as? String
        else {
                return nil
        }
        
        self.reportId = reportId
        self.reportCash = reportCash
        self.reportCreditCard = reportCreditCard
        self.reportDate = reportDate
    }
    
     var dictionaryRepresentation : [String:Any] {
           return [
               "reportId":reportId,
               "reportCash":reportCash,
               "reportCreditCard":reportCreditCard,
               "reportDate":reportDate
               
           ]
       }
}
