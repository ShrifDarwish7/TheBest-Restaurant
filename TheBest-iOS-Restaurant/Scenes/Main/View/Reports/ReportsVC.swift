//
//  ReportsVC.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/22/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class ReportsVC: UIViewController, UITextFieldDelegate {

    @IBOutlet var customTF: [UITextField]!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var ordersTableView: UITableView!
    @IBOutlet weak var empty: UILabel!
    @IBOutlet var customView: [UIView]!
    @IBOutlet weak var totalOrders: UILabel!
    @IBOutlet weak var totalMoney: UILabel!
    @IBOutlet weak var completed: UILabel!
    @IBOutlet weak var canceled: UILabel!
    
    var mainPresenter: MainPresenter?
    var selectedFromDate: Date?
    var selectedToDate: Date?
    var orders: [Order]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        mainPresenter = MainPresenter(mainViewDelegate: self)
    }
    
    func loadUI(){
        for tf in customTF{
            tf.addBottomBorder()
        }
        
        for v in customView{
            v.layer.cornerRadius = 15
        }
        
        fromTF.setInputViewDatePicker { (datePicker) in
            datePicker.onChange { (date) in
                let dateformatter = DateFormatter()
                dateformatter.dateStyle = .medium
                let date = dateformatter.string(from: datePicker.date)
                self.fromTF.text = date
                self.selectedFromDate = datePicker.date
            }
        }
        
        toTF.setInputViewDatePicker { (datePicker) in
            datePicker.onChange { (date) in
                let dateformatter = DateFormatter()
                dateformatter.dateStyle = .medium
                let date = dateformatter.string(from: datePicker.date)
                self.toTF.text = date
                self.selectedToDate = datePicker.date
            }
        }
        
    }
    
    @IBAction func back(sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func getReports(_ sender: Any) {
        if let _ = selectedFromDate , let _ = selectedToDate{
            mainPresenter?.getReports(from: selectedFromDate!, to: selectedToDate!)
        }
    }
    
    
}
