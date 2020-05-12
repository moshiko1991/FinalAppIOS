//
//  ReportsDetailsViewController.swift
//  FinalAppIOS
//
//  Created by moshiko elkalay on 11/03/2020.
//  Copyright © 2020 moshiko. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import MessageUI

class ReportsDetailsViewController: UIViewController {
    
    var businessName : String? {
        return Auth.auth().currentUser?.displayName
    }
    
    var currentReport : Report!
    
    var reportDetails : [ReportDetails] = []
    
    @IBOutlet weak var cash: UILabel!
    @IBOutlet weak var creditCard: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Report: "  + currentReport.reportId
        self.cash.text = "Cash: \(currentReport.cash)"
        self.creditCard.text = "Credit Card: \(currentReport.creditCard)"
        self.total.text = "Total: \(currentReport.cash + currentReport.creditCard)"
        self.date.text = "Date: \(currentReport.reportDate)"
        
        
        
    }
    
    @IBAction func mailAction(_ sender: Any) {
        //run on device
        showMailCompser()
    }
    
    func showMailCompser() {
        print("Get into this Function")
        guard MFMailComposeViewController.canSendMail() else {
            //show alert informing the user
            return
        }
    
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([Auth.auth().currentUser?.email as! String])
        composer.setSubject("Report: \(currentReport.reportId), \(currentReport.reportDate)")
        composer.setMessageBody("Report Details: \n Report ID: \(currentReport.reportId)" + "\n Report Cash: \(currentReport.cash)" + "\n Report CredidCard: \(currentReport.creditCard)" + "\n Total: \(total.text)", isHTML: false)
        
        present(composer, animated: true)
        
    }
    
    
    
    @IBAction func editAction(_ sender: Any) {
        
        let editAlert = UIAlertController(title: "Edit Report: \(self.currentReport.reportId)", message: nil, preferredStyle: .alert)
        
        editAlert.addTextField { (reportCash) in
            reportCash.placeholder = "Cash: \(self.currentReport.cash)"
        }
        
        editAlert.addTextField { (reportCreditCard) in
            reportCreditCard.placeholder = "Report Credit Card: \(self.currentReport.creditCard)"
        }
        
        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        editAlert.addAction(cancelAlert)
        
        let doneEditing = UIAlertAction(title: "Done", style: .default) { (_) in
            guard let textFields = editAlert.textFields else {
                return
            }
        }
    }
}

extension ReportsDetailsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            //show error alert
            controller.dismiss(animated: true)
            return
        }
        
        switch result {
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("Failed to send")
        case .saved:
            print("Saved")
        case .sent:
            print("Email Sent")
        }
        
        controller.dismiss(animated: true)
    }
}





