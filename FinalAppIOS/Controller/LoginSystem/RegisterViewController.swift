//
//  RegisterViewController.swift
//  ForumApp
//
//  Created by moshiko elkalay on 26/02/2020.
//  Copyright © 2020 moshiko. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var businessTextField: UITextField!
    
    @IBOutlet weak var regIdTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //open keyboard
        emailTextField.becomeFirstResponder()
    }
    

   
    @IBAction func submitAction(_ sender: UIButton) {
        
        guard let email = emailTextField.text, email.count > 0,
            let businessName = businessTextField.text, businessName.count > 0,
            let regId = regIdTextField.text, regId.count > 0,
            let address = addressTextField.text, address.count > 0,
            let phone = phoneTextField.text, phone.count > 0,
            let password = passwordTextField.text, password.count > 0,
            let confirmPassword = confirmPasswordTextField.text, confirmPassword == password else {
                print("content not valid")
                return
        }
        
        
        //disable button
        sender.isEnabled = false
        
        //create firebase user
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard let result = result else {
                if let error = error {
                    print("failed with error \(error)")
                    sender.isEnabled = true
                    return
                }
                return
                
            }
            
            //set nickname
            let request = result.user.createProfileChangeRequest()
            request.displayName = businessName
            request.commitChanges { (commitError) in
                //update main UI, create user was successful
                
                let info = BusinessInfo(
                                        businessName: businessName,
                                        regId: regId,
                                        address: address,
                                        phone: phone)
                
                
                
                let dbRef = Database.database().reference().child("Businesses")
                dbRef.child(businessName).setValue(info.dictonaryRepresentation)
                
                
                FlowController.shared.determineRoot()
                
            }
        }
        
    }
    
    
}
