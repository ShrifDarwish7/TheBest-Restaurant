//
//  ReportsVC+MainViewDelegate.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/23/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

extension ReportsVC: MainViewDelegate{
    
    func SVProgressStatus(_ show: Bool) {
        if show{
            SVProgressHUD.show()
        }else{
            SVProgressHUD.dismiss()
        }
    }
    
    func didCompleteWithReports(_ reports: ReportsResponse?) {
        if let _ = reports{
            if (reports?.myOrders.isEmpty)!{
                self.empty.isHidden = false
                self.ordersTableView.isHidden = true
            }else{
                self.orders = reports?.myOrders
                self.empty.isHidden = true
                self.loadOrdersTableFromNib()
                self.ordersTableView.isHidden = false
                self.canceled.text = "\(reports?.myOrdersCanceled ?? 0)"
                self.completed.text = "\(reports?.myOrdersDone ?? 0)"
                self.totalOrders.text = "\(reports?.myOrdersCount ?? 0)"
                self.totalMoney.text = "\(reports?.myOrdersMoney ?? 0) KWD"
            }
        }else{
            self.empty.isHidden = false
        }
    }
}
