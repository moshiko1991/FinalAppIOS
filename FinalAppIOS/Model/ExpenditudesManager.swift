//
//  ExpendituresManager.swift
//  FinalAppIOS
//
//  Created by moshiko elkalay on 12/03/2020.
//  Copyright © 2020 moshiko. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class ExpenditudesManager {
    static let manager = ExpenditudesManager()
    
    var businessName : String? {
        return Auth.auth().currentUser?.displayName
    }
    
    private lazy var expenditudesDatabseReference : DatabaseReference = {
        return Database.database().reference().child("Expenditudes")
    }()
    
    func createExpenditude(expenditudeTitle: String, expenditudeSum: Double, expenditudeDate: String) {
        guard let businessName = self.businessName else {
            return
        }
        
        let expenditude = Expenditude(expenditudeTitle: expenditudeTitle, expenditudeSum: expenditudeSum, expenditudeDate: expenditudeDate)
        
        expenditudesDatabseReference.child(businessName).childByAutoId().setValue(expenditude.dictonaryRepresentation)
    }
    
    func getAllExpendtiudes(with complition: @escaping ([Expenditude]) -> Void) {
        guard let businessName = self.businessName else {
            return
        }
        
        expenditudesDatabseReference.child(businessName).observeSingleEvent(of: .value) { (snapshot) in
            guard let json = snapshot.value as? [String:Any] else {
                complition([])
                return
            }
            
            let result = Array(json.values).compactMap{ $0 as? [String:Any]}.compactMap{ Expenditude($0) }
            complition(result)
        }
        
    }
    
    
    
    func crateExpenditudeDetails(with reportId: String, in expenditude: Expenditude) {
        guard let bName = self.businessName else {
            return
        }
        //crate object
        let currentExpenditude = ExpenditudeDetails(expenditudeTitle: expenditude.expenditudeTitle, expenditudeSum: "\(expenditude.expenditudeSum)", expenditudeDate: expenditude.expenditudeDate)
        
    }
    
    func listenToNewRport(in expenditude : Expenditude, with callback : @escaping (Expenditude) -> Void ) -> UInt {
        
        let ref = expenditudesDatabseReference.child(expenditude.expenditudeTitle)
        
        return ref.observe(.childAdded) { (snapshot) in
            guard let json = snapshot.value as? [String:Any] else {
                return
            }
            
            guard let expenditude = Expenditude(json) else {
                return
            }
            
            callback(expenditude)
            
        }
        
    }
}
