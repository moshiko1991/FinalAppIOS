//
//  ExpenditudeViewController.swift
//  FinalAppIOS
//
//  Created by moshiko elkalay on 13/03/2020.
//  Copyright © 2020 moshiko. All rights reserved.
//

import UIKit
import Firebase

class ExpenditudeViewController: UIViewController {
    
    var expendetuideTableArray : [Expenditude] = []
    
    
    @IBOutlet weak var expenditubeTableView: UITableView!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        expenditubeTableView.dataSource = self
        expenditubeTableView.delegate = self
        
        listenToData()
    }
    
    private func listenToData() {
        ExpenditudesManager.manager.getAllExpendtiudes { [weak self](expenditudes) in
            guard let self = self else { return }
            self.expendetuideTableArray = expenditudes
            self.expenditubeTableView.reloadData()
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
    
    
    
    
    @IBAction func addExpenditudeAction(_ sender: Any) {
        let alert = UIAlertController(title: "Add Expenditude", message: nil, preferredStyle: .alert)
        
        alert.addTextField  { $0.placeholder = "Expenditude Title:" }
        alert.addTextField  { $0.placeholder = "Expenditude Sum:" }
        
        alert.addTextField { (expenditudeDate) in
            expenditudeDate.placeholder = "Date:"
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .dateAndTime
            datePicker.backgroundColor = .systemBlue
            datePicker.addTarget(self, action: #selector(self.updateDate(_:)), for: .valueChanged)
            
            expenditudeDate.inputView = datePicker
            
        }
        
        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAlert)
        
        let createExpenditude = UIAlertAction(title: "Create Expenditude", style: .default) { (_) in
            
            guard let textFields = alert.textFields else {
                return
            }
            
            guard let expenditudeTitle = textFields[0].text, expenditudeTitle.count > 0,
                let expenditudeSum = textFields[1].text, expenditudeSum.count > 0,
                let expenditudeDate = textFields[2].text, expenditudeSum.count > 0
                else {
                    
                    return
            }
            
            let doubleSum = NSString(string: expenditudeSum).doubleValue
            
            ExpenditudesManager.manager.createExpenditude(expenditudeTitle: expenditudeTitle, expenditudeSum: doubleSum, expenditudeDate: expenditudeDate)
            
            self.listenToData()
        }
        
        alert.addAction(createExpenditude)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? ExpenditudeDetailsViewController,
            let indexPath = expenditubeTableView.indexPathForSelectedRow {
            nextVC.currentExpenditude = expendetuideTableArray[indexPath.row]
            
        }
    }
    
}


extension ExpenditudeViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expendetuideTableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expenditubeTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let expenditudeSum = expendetuideTableArray
        
        let totalSum = expenditudeSum.map{$0.expenditudeSum}.reduce(0.0, +)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        
        totalLabel.text = "Total: " + numberFormatter.string(from: NSNumber(value: totalSum))!
        
        
        let expenditude = expendetuideTableArray[indexPath.row]
        cell.textLabel?.text = expenditude.expenditudeTitle
        cell.detailTextLabel?.text = "\(expenditude.expenditudeSum) $"
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
