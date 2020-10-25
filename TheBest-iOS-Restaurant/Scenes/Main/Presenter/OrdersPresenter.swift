//
//  OrdersPresenter.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/17/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol OrdersViewDelegate {
    func SVProgressStatus(_ status: Bool)
    func didCompleteWith(_ orders: [Order]?)
}

extension OrdersViewDelegate{
    func SVProgressStatus(_ status: Bool){}
    func didCompleteWith(_ orders: [Order]?){}
}

class OrdersPresenter{
    
    var ordersViewDelegate: OrdersViewDelegate?
    
    init(_ ordersViewDelegate: OrdersViewDelegate) {
        self.ordersViewDelegate = ordersViewDelegate
    }
    
    func getOldOrers(){
        
        self.ordersViewDelegate?.SVProgressStatus(true)
        OrdersServices.getOldOrders { (response) in
            self.ordersViewDelegate?.SVProgressStatus(false)
            if let _ = response{
                self.ordersViewDelegate?.didCompleteWith(response!.oldOrders)
            }else{
                self.ordersViewDelegate?.didCompleteWith(nil)
            }
        }
        
    }
    
}
