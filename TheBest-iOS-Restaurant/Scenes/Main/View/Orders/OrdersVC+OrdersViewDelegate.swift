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
        if let _ = orders{
            self.oldOrders = orders
            self.loadOrdersTableFromNib()
        }
    }
    
    func didCompleteChangeStatus(_ done: Bool) {
        if done{
            let alert = UIAlertController(title: "", message: "Order status updated successfully".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done".localized, style: .default, handler: { (_) in
                self.ordersPresenter?.getOldOrers()
            }))
        }else{
            self.showAlert(title: "", message: "An error occured when updating order status, please try again later".localized)
        }
    }
}
