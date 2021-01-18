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
    func didCompleteChangeStatus(_ done: Bool)
    func didCompleteScheduleTrip(_ done: Bool)
}

extension OrdersViewDelegate{
    func SVProgressStatus(_ status: Bool){}
    func didCompleteWith(_ orders: [Order]?){}
    func didCompleteChangeStatus(_ done: Bool){}
    func didCompleteScheduleTrip(_ done: Bool){}
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
    
    func getNewOrers(){
        self.ordersViewDelegate?.SVProgressStatus(true)
        OrdersServices.getNewOrders { (response) in
            self.ordersViewDelegate?.SVProgressStatus(false)
            if let _ = response{
                self.ordersViewDelegate?.didCompleteWith(response!.data)
            }else{
                self.ordersViewDelegate?.didCompleteWith(nil)
            }
        }
    }
    
    func changeOrderStatus(id: String, status: String){
        self.ordersViewDelegate?.SVProgressStatus(true)
        OrdersServices.changeOrderStatus(id: id, status: status) { (done) in
            self.ordersViewDelegate?.SVProgressStatus(false)
            if done{
                self.ordersViewDelegate?.didCompleteChangeStatus(true)
            }else{
                self.ordersViewDelegate?.didCompleteChangeStatus(false)
            }
        }
    }
    
    func scheduleTrip(id: String,_ parameters: [String:Any]){
        self.ordersViewDelegate?.SVProgressStatus(true)
        OrdersServices.scheduleTripWith(parameters, id: id) { (done) in
            self.ordersViewDelegate?.SVProgressStatus(false)
            if done{
                self.ordersViewDelegate?.didCompleteScheduleTrip(true)
            }else{
                self.ordersViewDelegate?.didCompleteScheduleTrip(false)
                
            }
        }
    }
    
}
