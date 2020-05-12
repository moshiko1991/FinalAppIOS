////
////  endOfDayInsert.swift
////  FinalAppIOS
////
////  Created by moshiko elkalay on 29/02/2020.
////  Copyright © 2020 moshiko. All rights reserved.
////
//
//import Foundation
//import Firebase
//
//struct businessInformation {
//
//    static var databseReference : DatabaseReference {
//        return Database.database().reference().child("Chatrooms")
//    }
//
//    let businessId : Int
//    let businessName : String
//    let businessOwner : String
//    let businessPhone : String
//    let businessAddress : String
//    let lastChange : Date
//
//    init?(businessName : String) {
//        guard let user = Auth.auth().currentUser else {
//            return nil
//        }
//
//        //usniversal unique identifier
////        self.businessId =
////        self.businessName =
////        self.businessOwner = user.displayName ?? ""
////        self.businessPhone =
////        self.businessAddress =
////        self.lastChange = Date()
//    }
//
//    var dictonaryRepresentation : [String:Any] {
//        return [
//            "business_id":businessId,
//            "business_name":businessName,
//            "business_owner":businessOwner,
//            "business_phone":businessPhone,
//            "last_change":lastChange.timeIntervalSince1970
//        ]
//    }
//
//    func save() {
//        Chatroom.databseReference.child(self.id).setValue(self.dictonaryRepresentation)
//    }
//
//}
