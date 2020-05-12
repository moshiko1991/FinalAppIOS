//
//  ReportsViewController.swift
//  FinalAppIOS
//
//  Created by moshiko elkalay on 04/03/2020.
//  Copyright © 2020 moshiko. All rights reserved.
//

import UIKit
import Firebase

class ReportsViewController: UIViewController {
    
    var reportTableArray : [Report] = []
 
    @IBOutlet weak var totalLabel: UILabel!
    
    
    @IBOutlet weak var reportsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        reportsTableView.dataSource = self
        reportsTableView.delegate = self
        
        listenToData()
        //totalSum()
    }
    
    private func listenToData() {
        ReportsManager.manager.getAllReports { [weak self](reports) in
            guard let self = self else { return }
            self.reportTableArray = reports
            self.reportsTableView.reloadData()
            
            
        }
    }
    
    
    
    
    @objc func updateDate(_ sender : UIDatePicker){
        print(sender.date)
        
        guard let alertController = self.presentedViewController as? UIAlertController else {
            return
        }
        guard let dateTextField = alertController.textFields?.last else {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        //dateFormatter.dateStyle = .medium
        
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    
    
    
    @IBAction func addReportAction(_ sender: Any) {
        let alert = UIAlertController(title: "Add Report", message: nil, preferredStyle: .alert)
        
        //report ID Alert text
        alert.addTextField { (reportId) in
            reportId.keyboardType = .numberPad
            reportId.placeholder = "Z Report ID:"
            
        }
        
        //report Cash Alert text
        alert.addTextField { (reportCash) in
            reportCash.keyboardType = .numberPad
            reportCash.placeholder = "Cash:"
            
        }
        
        
        alert.addTextField { (reportCreditCard) in
            reportCreditCard.keyboardType = .numberPad
            reportCreditCard.placeholder = "Credit Card:"
            
        }
        
        
        alert.addTextField { (reportDate) in
            reportDate.placeholder = "Date:"
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .dateAndTime
            datePicker.backgroundColor = .systemBlue
            datePicker.addTarget(self, action: #selector(self.updateDate(_:)), for: .valueChanged)
            
            reportDate.inputView = datePicker
            self.listenToData()
            
        }
        
        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAlert)
        
        let createReport = UIAlertAction(title: "Create Report", style: .default) { (_) in
            guard let textFields = alert.textFields else {
                return
            }
            
            guard let reportId = textFields[0].text, reportId.count > 0,
                let cash = textFields[1].text, cash.count > 0,
                let creditCard = textFields[2].text, creditCard.count > 0,
                let reportDate = textFields[3].text, reportDate.count > 0
                
                else {
                    return
            }
            
            let doubleCash = NSString(string: cash).doubleValue
            let doubleCreditCard = NSString(string: creditCard).doubleValue
            
            
            ReportsManager.manager.createReport(with: reportId, cash: doubleCash, creditCard: doubleCreditCard, reportDate: reportDate)
            
            self.listenToData()
        }
        
        
        alert.addAction(createReport)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? ReportsDetailsViewController,
            let indexPath = reportsTableView.indexPathForSelectedRow {
            nextVC.currentReport = reportTableArray[indexPath.row]
            
        }
    }
    
    
}

extension ReportsViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportTableArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reportsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let totalSum = reportTableArray.map{$0.cash + $0.creditCard}.reduce(0.0, +)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        
        totalLabel.text = "Total: " + numberFormatter.string(from: NSNumber(value: totalSum))!
        
        
        let report = reportTableArray[indexPath.row]
        let total = report.cash + report.creditCard
        
        
        cell.textLabel?.text = "Z reprot: " + report.reportId
        cell.detailTextLabel?.text = numberFormatter.string(from: NSNumber(value: total))! + " $"
        
        if total <= 200 {
            cell.detailTextLabel?.textColor = .systemRed
        } else if total <= 500{
            cell.detailTextLabel?.textColor = .systemOrange
        } else {
            cell.detailTextLabel?.textColor = .systemGreen
        }
        
        
        return cell
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

