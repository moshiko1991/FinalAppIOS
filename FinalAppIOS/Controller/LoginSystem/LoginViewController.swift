//
//  LoginViewController.swift
//  ForumApp
//
//  Created by moshiko elkalay on 26/02/2020.
//  Copyright © 2020 moshiko. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        guard let email = emailTextField.text, email.count > 0,
            let password = passwordTextField.text, password.count > 0 else {
                print("content not valid")
                return
        }
        
        sender.isEnabled = false
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("failed with error \(error)")
                sender.isEnabled = true
                return
            }
            
            FlowController.shared.determineRoot()
        }
    }
    
}
