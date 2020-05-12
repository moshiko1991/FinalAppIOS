//
//  UserDatabase.swift
//  FinalAppIOS
//
//  Created by moshiko elkalay on 01/03/2020.
//  Copyright © 2020 moshiko. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

struct userData {
    
    let businessName : String
    let regId : String
    let address : String
    let phone : String
    
    init?(businessName : String, regId : String, address : String, phone : String) {
        self.businessName = Auth.auth().currentUser?.displayName as! String
        self.regId = regId
        self.address = address
        self.phone = phone
    }
    
    init?(_ dictonary : [String:Any]) {
        guard let businessName = dictonary["businessName"] as? String,
              let regId = dictonary["regId"] as? String,
              let address = dictonary["address"] as? String,
            let _ = dictonary["phone"] as? String
              return nil
        else {
            <#statements#>
        }
    }
    
}
