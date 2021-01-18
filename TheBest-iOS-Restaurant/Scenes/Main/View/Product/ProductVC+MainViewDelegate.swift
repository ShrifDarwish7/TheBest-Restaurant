//
//  ProductVC+MainViewDelegate.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/26/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

extension ProductVC: MainViewDelegate{
    
    func didCompleteWithMenus(_ menus: [MyMenu]?) {
        if let _ = menus{
            self.menus = menus
            loadMenuPickerView()
        }
    }
    
    func loadMenuPickerView(){
        setupPicker(textField: menuPickerTF, picker: menuPicker)
        menuPicker.numberOfRowsInComponent { (_) -> Int in
            return self.menus!.count
        }.titleForRow { (row, _) -> String? in
            return self.menus![row].name
        }.didSelectRow { (row, _) in
            self.menuPickerTF.text = self.menus![row].name
            self.selectedMenuID = self.menus![row].id
        }
    }
    
    func activityIndicatorStatus(_ show: Bool) {
        if show{
            self.activityIndicator.startAnimating()
        }else{
            self.activityIndicator.stopAnimating()
        }
    }
    
    func didCompleteWithAdditionalItems(_ items: [AdditionalItem]?) {
        if let _ = items{
            self.additionalItems = items
            self.loadCollectionFromNib()
        }
    }
    
    func didCompleteAddingProduct(_ completed: Bool) {
        SVProgressHUD.dismiss()
        if completed{
            showAlert(title: "", message: "Product added successfully")
        }else{
            showAlert(title: "", message: "An error occured when adding product, please try again later")
        }
    }
    
    func didCompleteUpdateProduct(_ completed: Bool) {
        SVProgressHUD.dismiss()
        if completed{
            showAlert(title: "", message: "Product updated successfully")
        }else{
            showAlert(title: "", message: "An error occured when updating product, please try again later")
        }
    }
    
}
