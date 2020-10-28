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
            self.dismissCatView()
            self.loadTableFromNib()
            refreshControl.endRefreshing()
        }
    }
    
    func didCompleteAddMenu(_ completed: Bool) {
        if completed{
            self.dismissCatView()
            self.mainPresenter?.getMenus()
        }else{
            showAlert(title: "", message: "Failed to add menu")
        }
    }
    
    func didCompleteDeleteMenu(_ completed: Bool) {
        if completed{
            mainPresenter?.getMenus()
        }
    }
    
    func didCompleteUpdateMenu(_ completed: Bool) {
        if completed{
            self.mainPresenter?.getMenus()
        }
    }
    
}
