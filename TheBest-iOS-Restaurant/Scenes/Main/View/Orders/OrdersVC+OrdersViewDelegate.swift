//
//  OrdersVC+OrdersViewDelegate.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/23/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

extension OrdersVC: OrdersViewDelegate{
    func SVProgressStatus(_ show: Bool) {
        if show{
            SVProgressHUD.show()
        }else{
            SVProgressHUD.dismiss()
        }
    }
    
    func didCompleteWith(_ orders: [Order]?) {
        refreshControl.endRefreshing()
        if let _ = orders{
            self.oldOrders = orders?.reversed()
            self.loadOrdersTableFromNib()
        }
    }
    
    func didCompleteChangeStatus(_ done: Bool) {
        if done{
            self.showAlert(title: "", message: "Order status updated successfully".localized)
            self.ordersPresenter?.getNewOrers()
            self.showScheduleView()
        }else{
            self.showAlert(title: "", message: "An error occured when updating order status, please try again later".localized)
        }
    }
    
    func didCompleteScheduleTrip(_ done: Bool) {
        if done{
            print("didCompleteScheduleTrip")
        }else{
            print("didCompleteScheduleTrip failed")
        }
    }
    
}
