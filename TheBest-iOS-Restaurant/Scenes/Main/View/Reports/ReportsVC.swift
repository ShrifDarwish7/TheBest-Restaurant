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
    @IBOutlet weak var datePickerViewContainerBottomCnst: NSLayoutConstraint!
    @IBOutlet weak var pickerView: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        
    }
    
    func loadUI(){
        for tf in customTF{
            tf.addBottomBorder()
            tf.addTarget(self, action: #selector(showPicker), for: .editingDidBegin)
            tf.inputAccessoryView = UIView()
        }
        datePickerViewContainerBottomCnst.constant = -self.view.frame.height
        self.view.addTapGesture { (_) in
            self.dismissPicker()
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func showPicker(){
       datePickerViewContainerBottomCnst.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func dismissPicker(){
        datePickerViewContainerBottomCnst.constant = -self.view.frame.height
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showPicker()
    }

    @IBAction func dismissPickerFromDone(_ sender: Any) {
        self.dismissPicker()
    }
}
