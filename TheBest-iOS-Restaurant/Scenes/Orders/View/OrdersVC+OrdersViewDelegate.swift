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
}
