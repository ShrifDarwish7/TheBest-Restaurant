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
    func didCompleteWithReports(_ reports: ReportsResponse?)
    func didCompleteWithMenuItems(_ items: [RestaurantMenuItem]?)
}

extension MainViewDelegate{
    func SVProgressStatus(_ show: Bool){}
    func didCompleteWithMenus(_ menus: [MyMenu]?){}
    func didCompleteAddMenu(_ completed: Bool){}
    func didCompleteWithReports(_ reports: ReportsResponse?){}
    func didCompleteWithMenuItems(_ items: [RestaurantMenuItem]?){}
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
    
    func getReports(from: Date, to: Date){
        self.mainViewDelegate?.SVProgressStatus(true)
        var fromPrms: String?
        var toPrms: String?
        let calendar = Calendar.current
        let componentsFrom = calendar.dateComponents([.day,.month,.year], from: from)
        let componentsTo = calendar.dateComponents([.day,.month,.year], from: to)
        if let day = componentsFrom.day, let month = componentsFrom.month, let year = componentsFrom.year {
            fromPrms = String(day) + "-" + String(month) + "-" + String(year)
        }
        
        if let day = componentsTo.day, let month = componentsTo.month, let year = componentsTo.year {
            toPrms = String(day) + "-" + String(month) + "-" + String(year)
        }
        
        guard let _ = fromPrms, let _ = toPrms else{
            self.mainViewDelegate?.didCompleteWithReports(nil)
            return
        }
        
        APIServices.getRestaurantsReports(fromPrms!, toPrms!) { (response) in
            self.mainViewDelegate?.SVProgressStatus(false)
            if let _ = response{
                self.mainViewDelegate?.didCompleteWithReports(response)
            }else{
                self.mainViewDelegate?.didCompleteWithReports(nil)
            }
        }
    }
  
    func getMenuItems(id: Int){
        self.mainViewDelegate?.SVProgressStatus(true)
        APIServices.getMenuItems(id, completed: { (response) in
            self.mainViewDelegate?.SVProgressStatus(false)
            for i in 0...response.count-1{
                var variations = [Variation]()
                if  let _ = response[i].attributeTitle ,
                    let _ = response[i].attributeTitleEn ,
                    let _ = response[i].attributeBody{
                    
                    if let bodyDecoded = try? JSONDecoder.init().decode([BodyItem].self, from: response[i].attributeBody?.replacingOccurrences(of: "\\", with: "").data(using: .utf8) ?? Data()){
                        variations.append(Variation(titleAr: response[i].attributeTitle!, titleEn: response[i].attributeTitleEn!, body: bodyDecoded))
                    }
                }
                if  let _ = response[i].attributeTitleTwo ,
                    let _ = response[i].attributeTitleEnTwo ,
                    let _ = response[i].attributeBodyTwo{
                    
                    if let bodyDecoded = try? JSONDecoder.init().decode([BodyItem].self, from: response[i].attributeBodyTwo?.replacingOccurrences(of: "\\", with: "").data(using: .utf8) ?? Data()){
                        variations.append(Variation(titleAr: response[i].attributeTitleTwo!, titleEn: response[i].attributeTitleEnTwo!, body: bodyDecoded))
                    }
                }
                if  let _ = response[i].attributeTitleThree ,
                    let _ = response[i].attributeTitleEnThree ,
                    let _ = response[i].attributeBodyThree{
                    
                    if let bodyDecoded = try? JSONDecoder.init().decode([BodyItem].self, from: response[i].attributeBodyThree?.replacingOccurrences(of: "\\", with: "").data(using: .utf8) ?? Data()){
                        variations.append(Variation(titleAr: response[i].attributeTitleThree!, titleEn: response[i].attributeTitleEnThree!, body: bodyDecoded))
                    }
                }
                response[i].variations = variations
                //print("body\(i)",response[i].variations)
            }
            self.mainViewDelegate?.didCompleteWithMenuItems(response)
        }) { (failed) in
            self.mainViewDelegate?.SVProgressStatus(false)
        }
        
    }
    
}
