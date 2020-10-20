//
//  CategoriesVC+MainViewDelegate.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/20/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

extension CategoriesVC: MainViewDelegate{
    func SVProgressStatus(_ show: Bool) {
        if show{
            SVProgressHUD.show()
        }else{
            SVProgressHUD.dismiss()
        }
    }
    
    func didCompleteWithMenus(_ menus: [MyMenu]?) {
        if let _ = menus{
            self.menus = menus
            self.loadTableFromNib()
        }
    }
    
    func didCompleteAddMenu(_ completed: Bool) {
        if completed{
            showAlert(title: "", message: "Menu added successfully")
            self.dismissCatView()
        }else{
            showAlert(title: "", message: "Failed to add menu")
        }
    }
}
