//
//  OrdersVC+TableViewDelegate.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/6/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension OrdersVC: UITableViewDelegate, UITableViewDataSource{
    
    func loadOrdersTableFromNib(){
        
        let nib = UINib(nibName: "OrdersTableViewCell", bundle: nil)
        self.ordersTableView.register(nib, forCellReuseIdentifier: "OrdersTableViewCell")
        
        self.ordersTableView.delegate = self
        self.ordersTableView.dataSource = self
        
        self.ordersTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersTableViewCell", for: indexPath) as! OrdersTableViewCell
        cell.loadUI()
        cell.name.text = orders[indexPath.row].title
        cell.expandBtn.tag = indexPath.row
       // cell.expandBtn.addTarget(self, action: #selector(expandItems(sender:)), for: .touchUpInside)
        
        let nib = UINib(nibName: "OrdersItemsTableViewCell", bundle: nil)
        cell.itemsTableView.register(nib, forCellReuseIdentifier: "OrdersItemsTableViewCell")
        
        cell.itemsTableView.numberOfRows { (_) -> Int in
            return 5
        }.cellForRow { (index) -> UITableViewCell in
            
            let cell = cell.itemsTableView.dequeueReusableCell(withIdentifier: "OrdersItemsTableViewCell", for: index) as! OrdersItemsTableViewCell
            cell.loadUI()
            return cell
            
        }.heightForRowAt { (_) -> CGFloat in
            return 110
        }
        
        cell.itemsTableView.reloadData()
        
        if orders[indexPath.row].expanded{
            cell.expandBtn.setImage(UIImage(named: "up-arrow"), for: .normal)
            UIView.animate(withDuration: 0.25) {
                cell.itemsTableView.isHidden = false
                cell.itemsViewHeight.constant = (110 * 5) + 80
                cell.itemsTableViewHeight.constant = (110 * 5)
                self.view.layoutIfNeeded()
            }
        }else{
            cell.expandBtn.setImage(UIImage(named: "down-arrow"), for: .normal)
            UIView.animate(withDuration: 0.25) {
                cell.itemsTableView.isHidden = true
                cell.itemsViewHeight.constant = 70
                cell.itemsTableViewHeight.constant = 0
                self.view.layoutIfNeeded()
            }
        }
        
        cell.itemsView.addTapGesture { (_) in
            self.orders[indexPath.row].expanded = !self.orders[indexPath.row].expanded
//            if self.orders[indexPath.row].expanded{
//                cell.expandBtn.setImage(UIImage(named: "up-arrow"), for: .normal)
//            }else{
//                cell.expandBtn.setImage(UIImage(named: "down-arrow"), for: .normal)
//            }
            self.ordersTableView.scrollToRow(at: IndexPath(row: indexPath.row, section: 0), at: .top, animated: true)
            self.ordersTableView.reloadData()
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if orders[indexPath.row].expanded{
            return (110 * 5) + 280
        }else{
            return 275
        }
    }
    
//    @objc func expandItems(sender: UIButton){
//        self.orders[sender.tag].expanded = !self.orders[sender.tag].expanded
//        if self.orders[sender.tag].expanded{
//            sender.setImage(UIImage(named: "up-arrow"), for: .normal)
//        }else{
//            sender.setImage(UIImage(named: "down-arrow"), for: .normal)
//        }
//       // self.ordersTableView.scrollToRow(at: IndexPath(row: sender.tag, section: 0), at: .middle, animated: true)
//        self.ordersTableView.reloadData()
//    }
    
}