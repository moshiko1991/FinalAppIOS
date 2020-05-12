//
//  ExpenditudeDetailsViewController.swift
//  FinalAppIOS
//
//  Created by moshiko elkalay on 19/03/2020.
//  Copyright © 2020 moshiko. All rights reserved.
//

import UIKit

class ExpenditudeDetailsViewController: UIViewController {
    
    var currentExpenditude : Expenditude!
    
    var expenditudeDeatails : [ExpenditudeDetails] = []
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var sumLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Expenditude: "  + currentExpenditude.expenditudeTitle
        self.titleLabel.text = "Sum: \(currentExpenditude.expenditudeSum)"
        self.dateLabel.text = "Date: \(currentExpenditude.expenditudeDate)"
        
    }
    
    
    

}
