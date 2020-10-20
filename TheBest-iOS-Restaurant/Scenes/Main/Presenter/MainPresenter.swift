//
//  MainPresenter.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/20/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol MainViewDelegate {
    func SVProgressStatus(_ show: Bool)
    func didCompleteWithMenus(_ menus: [MyMenu]?)
    func didCompleteAddMenu(_ completed: Bool)
}

extension MainViewDelegate{
    func SVProgressStatus(_ show: Bool){}
    func didCompleteWithMenus(_ menus: [MyMenu]?){}
    func didCompleteAddMenu(_ completed: Bool){}
}

class MainPresenter{
    
    var mainViewDelegate: MainViewDelegate?
    
    init(mainViewDelegate: MainViewDelegate) {
        self.mainViewDelegate = mainViewDelegate
    }
    
    func getMenus(){
        self.mainViewDelegate!.SVProgressStatus(true)
        APIServices.getMenus { (response) in
            self.mainViewDelegate?.SVProgressStatus(false)
            if let _ = response{
                self.mainViewDelegate?.didCompleteWithMenus(response?.myMenus)
            }else{
                self.mainViewDelegate?.didCompleteWithMenus(nil)
            }
        }
    }
    
    func addMenu(name: String){
        self.mainViewDelegate!.SVProgressStatus(true)
        APIServices.addMenu(name) { (completed) in
            self.mainViewDelegate!.SVProgressStatus(false)
            if completed{
                self.mainViewDelegate?.didCompleteAddMenu(true)
            }else{
                self.mainViewDelegate?.didCompleteAddMenu(false)
            }
        }
    }
    
}
