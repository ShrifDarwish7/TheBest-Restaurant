//
//  OrdersVC.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/6/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

struct order {
    var title: String
    var expanded: Bool
}

class OrdersVC: UIViewController , UIGestureRecognizerDelegate{

    @IBOutlet weak var ordersTableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var drawerBtn: UIButton!
    @IBOutlet weak var drawerPosition: NSLayoutConstraint!
    
  //  var orders = [order]()
    var oldOrders: [Order]?
    var ordersPresenter: OrdersPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

//        orders.append(order(title: "order1", expanded: false))
//        orders.append(order(title: "order2", expanded: false))
//        orders.append(order(title: "order3", expanded: false))
//        orders.append(order(title: "order4", expanded: false))
//        orders.append(order(title: "order5", expanded: false))
        
        NotificationCenter.default.addObserver(self, selector: #selector(closeDrawer), name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
        loadUI()
        ordersPresenter = OrdersPresenter(self)
        ordersPresenter?.getOldOrers()
    }
    
    func loadUI(){
        
        drawerPosition.constant = self.view.frame.width
        upperView.setupShadow()
        upperView.layer.cornerRadius = upperView.frame.height/2
        
        drawerBtn.onTap {
            Drawer.open(self.drawerPosition, self)
        }
        
        backBtn.onTap {
            self.navigationController?.popViewController(animated: true)
        }
        
    }

    @objc func closeDrawer(){
        Drawer.close(drawerPosition, self)
    }

}
