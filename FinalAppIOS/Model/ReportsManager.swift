//
//  BusinessInfo.swift
//  FinalAppIOS
//
//  Created by moshiko elkalay on 01/03/2020.
//  Copyright © 2020 moshiko. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class ReportsManager {
    static let manager = ReportsManager()
    
    var businessName : String? {
        return Auth.auth().currentUser?.displayName
    }
    
    private lazy var reportsDatabseReference : DatabaseReference = {
        return Database.database().reference().child("Reports")
    }()
    
    
    func createReport(with reportId : String, cash : Double, creditCard : Double, reportDate : String) {
        guard let businessName = self.businessName else {
            return
        }
        
        let report = Report(reportId: reportId, cash: cash, creditCard: creditCard, reportDate: reportDate)
        reportsDatabseReference.child(businessName).childByAutoId().setValue(report.dictonaryRepresentation)
    }
    
    func getAllReports(with complition : @escaping ([Report]) -> Void) {
        guard let businessName = self.businessName else {
            return
        }
        
        reportsDatabseReference.child(businessName).observeSingleEvent(of: .value) { (snapshot) in
            guard let json = snapshot.value as? [String:Any] else {
                complition([])
                return
            }
            
            
            let result = Array(json.values).compactMap{ $0 as? [String:Any]}.compactMap{ Report($0) }
            
            complition(result)
            
        }
    }
    
    func crateReportDetails(with reportId: String, in report: Report) {
        guard let bName = self.businessName else {
            return
        }
        //crate object
        let currentReport = ReportDetails(reportId: report.reportId,
                                          reportCash: "\(report.cash)", reportCredirCard:"\(report.creditCard)",reportDate: report.reportDate)
        
    }
    
    func listenToNewRport(in report : Report, with callback : @escaping (Report) -> Void ) -> UInt {
        
        let ref = reportsDatabseReference.child(report.reportId)
        
        return ref.observe(.childAdded) { (snapshot) in
            guard let json = snapshot.value as? [String:Any] else {
                return
            }
            
            guard let report = Report(json) else {
                return
            }
            
            callback(report)
            
        }
        
    }
}








