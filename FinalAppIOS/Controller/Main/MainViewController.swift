//
//  MainViewController.swift
//  ForumApp
//
//  Created by moshiko elkalay on 26/02/2020.
//  Copyright © 2020 moshiko. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MainViewController: UIViewController {
    
    //Reference withe firebase Database for business information
    private lazy var databseReference : DatabaseReference = {
        return Database.database().reference().child("Businesses").child(Auth.auth().currentUser?.displayName as! String)
    }()
    
    //Reference withe firebase Database for business reports
    private lazy var reportsReference : DatabaseReference = {
        return Database.database().reference().child("Reports")
    }()
    
    //Reference withe firebase Database for business expenditudes
    private lazy var expenditudesReference : DatabaseReference = {
        return Database.database().reference().child("Expenditudes")
    }()
    
    //Outlets from Main storyboard
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var phoneBusiness: UILabel!
    @IBOutlet weak var regIDBusiness: UILabel!
    @IBOutlet weak var addressBusiness: UILabel!
    @IBOutlet weak var reporCounterLabel: UILabel!
    @IBOutlet weak var expenditudeCounterLabel: UILabel!
    @IBOutlet weak var lastReportLabel: UILabel!
    @IBOutlet weak var lastExpenditudeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getName()
        getPhone()
        getAddress()
        getRegId()
        showGreeting()
        getReports()
        getExpenditudes()
        
        
    }
    
    func backgorundColor(stackView : UIStackView) {
        let subView = UIView(frame: .zero)
        subView.backgroundColor = .systemBlue
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        stackView.addSubview(subView)
    }
    
    func removeStrings(text : String) -> String {
        let one = text.replacingOccurrences(of: "{", with: "", options: .forcedOrdering)
        let two = one.replacingOccurrences(of: "}", with: "", options: .forcedOrdering)
        let three = two.replacingOccurrences(of: ";", with: "", options: .forcedOrdering)
        let four = three.replacingOccurrences(of: "=", with: ":", options: .forcedOrdering)
        let five = four.replacingOccurrences(of: "creditCard", with: "Credit Card", options: .forcedOrdering)
        let six = five.replacingOccurrences(of: "reportDate", with: "Date", options: .forcedOrdering)
        let seven = six.replacingOccurrences(of: "reportId", with: "Reort ID", options: .forcedOrdering)
        let eight = seven.replacingOccurrences(of: "expenditudeDate", with: "Date", options: .forcedOrdering)
        let nine = eight.replacingOccurrences(of: "expenditudeSum", with: "Sum", options: .forcedOrdering)
        let ten = nine.replacingOccurrences(of: "expenditudeTitle", with: "Title", options: .forcedOrdering)
        let eleven = ten.replacingOccurrences(of: "cash", with: "Cash", options: .forcedOrdering)
        return eleven
    }
    
    func getExpenditudes(){
        //Inner reports reference for dictionary
        expenditudesReference.child(Auth.auth().currentUser?.displayName as! String).observe(.value) { (snapshot) in
            
            let dictionary = snapshot.value as! NSDictionary
            
            var expenditudesArray : Array<Any> = []
            
            //Put the the dictionry to new array
            expenditudesArray.append(dictionary)
            
            //print(reportsArray)
            let keysArray : Array<Any> = dictionary.allKeys
            
            //get last key from allKeys
            let lastKey = keysArray.count - 1
            //print(lastKey)
            let valuesArray = dictionary.value(forKey: "\(keysArray[lastKey])")
            
            //print(valuesArray!)
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = 2
            
            let stringValues = "\(valuesArray!)"
            
            self.lastExpenditudeLabel.text = "Last Expenditude: \n" + self.removeStrings(text: stringValues)
            
            //Change the report caunter label text to the number of reports wiht count
            self.expenditudeCounterLabel.text = "Expendituds: \(dictionary.count)"
            
            return
        }
        
    }
    
    func getReports(){
        //Inner reports reference for dictionary
        reportsReference.child(Auth.auth().currentUser?.displayName as! String).observe(.value) { (snapshot) in
            
            let dictionary = snapshot.value as! NSDictionary
            
            var reportsArray : Array<Any> = []
            
            //Put the the dictionry to new array
            reportsArray.append(dictionary)
            
            //print(reportsArray)
            
            let keysArray : Array<Any> = dictionary.allKeys
            
            print(keysArray)
            
            //get last key from allKeys
            
            let lastKey = keysArray.count - keysArray.count + 1
            print(lastKey)
            let valuesArray = dictionary.value(forKey: "\(keysArray[lastKey])")
            
            print(valuesArray!)
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = 2
            
            
            
            let stringValues = "\(valuesArray!)"

            
            self.lastReportLabel.text = "Last Report: \n " + self.removeStrings(text: stringValues)
            
            //Change the report caunter label text to the number of reports wiht count
            self.reporCounterLabel.text = "Reports: \(dictionary.count)"
            
            return
        }
        
    }
    
    
    private func getAddress() {
        databseReference.child("address").observeSingleEvent(of: .value) { (snapshot) in
            guard let address = snapshot.value as? String else{
                return
            }
            
            self.addressBusiness.text = "Business Address: " + address
        }
    }
    
    private func getRegId() {
        databseReference.child("regId").observeSingleEvent(of: .value) { (snapshot) in
            guard let regId = snapshot.value as? String else{
                return
            }
            
            self.regIDBusiness.text = "Busniess Number: " + regId
        }
    }
    
    
    private func getName() {
        databseReference.child("businessName").observeSingleEvent(of: .value) { (snapshot) in
            guard let name = snapshot.value as? String else{
                return
            }
            
            self.businessName.text = "Business Name: " + name
        }
    }
    
    private func getPhone() {
        databseReference.child("phone").observeSingleEvent(of: .value) { (snapshot) in
            guard let phone = snapshot.value as? String else{
                return
            }
            
            self.phoneBusiness.text = "Business Phone: " + phone
        }
    }
    
    private func showGreeting() {
        //obtain users display name
        guard let businessName = Auth.auth().currentUser?.displayName else {
            return
        }
        
        //show it on navigation item
        navigationItem.title = businessName
        
    }
    
    
}
    
  




