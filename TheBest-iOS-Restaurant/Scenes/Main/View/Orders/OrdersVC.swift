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
    @IBOutlet weak var schViewPosition: NSLayoutConstraint!
    @IBOutlet weak var blockView: UIView!
    @IBOutlet weak var scheduleView: UIView!
    @IBOutlet weak var chooseImg1: UIImageView!
    @IBOutlet weak var chooseImg2: UIImageView!
    @IBOutlet weak var chooseImg3: UIImageView!
    @IBOutlet weak var minutesTF: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!
    
  //  var orders = [order]()
    var oldOrders: [Order]?
    var ordersPresenter: OrdersPresenter?
    var refreshControl = UIRefreshControl()
    var selectedTripSchedule: String?
    var acceptedOrderId: String?
    var orders: Orders = .old
    var acceptedOrder: Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        ordersTableView.addSubview(refreshControl)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        schViewPosition.constant = self.view.frame.height
        confirmBtn.layer.cornerRadius = 15
//        orders.append(order(title: "order1", expanded: false))
//        orders.append(order(title: "order2", expanded: false))
//        orders.append(order(title: "order3", expanded: false))
//        orders.append(order(title: "order4", expanded: false))
//        orders.append(order(title: "order5", expanded: false))
        scheduleView.layer.cornerRadius = 15
        minutesTF.addBottomBorder()
        NotificationCenter.default.addObserver(self, selector: #selector(closeDrawer), name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(incomingNewOrder), name: NSNotification.Name(rawValue: "IncomingNewOrder"), object: nil)
        loadUI()
        ordersPresenter = OrdersPresenter(self)
        switch orders {
        case .old:
            ordersPresenter?.getOldOrers()
        default:
            ordersPresenter?.getNewOrers()
        }
        
//        self.upperView.isUserInteractionEnabled = true
//        self.view.addTapGesture { (_) in
//            self.showScheduleView()
//        }
    }
    
    @objc func incomingNewOrder(){
        ordersPresenter?.getNewOrers()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        switch orders {
        case .old:
            ordersPresenter?.getOldOrers()
        default:
            ordersPresenter?.getNewOrers()
        }
    }
    
    func showScheduleView(){
        self.schViewPosition.constant = 0
        self.blockView.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            
        }
    }
    
    @IBAction func close(_ sender: Any) {
        dismissScheduleView()
    }
    
    func dismissScheduleView(){
        self.schViewPosition.constant = self.view.frame.height
        self.blockView.isHidden = true
        self.view.layoutIfNeeded()
        self.view.endEditing(true)
    }
    
    func loadUI(){
        
        drawerPosition.constant = "lang".localized == "ar" ? self.view.frame.width : -self.view.frame.width
        upperView.setupShadow()
        upperView.layer.cornerRadius = upperView.frame.height/2
        
        drawerBtn.onTap {
            Drawer.open(self.drawerPosition, self)
        }
        
        backBtn.onTap {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    @IBAction func chooseTimeAction(_ sender: UIButton) {
        
        chooseImg1.image = UIImage(named: "unchoosed")
        chooseImg2.image = UIImage(named: "unchoosed")
        chooseImg3.image = UIImage(named: "unchoosed")
        
        switch sender.tag {
        case 0:
            chooseImg1.image = UIImage(named: "choosed")
            self.selectedTripSchedule = ""
            self.view.endEditing(true)
            UIView.animate(withDuration: 0.2) {
                self.minutesTF.isHidden = true
            }
        case 1:
            chooseImg2.image = UIImage(named: "choosed")
            self.selectedTripSchedule = "15"
            self.view.endEditing(true)
            UIView.animate(withDuration: 0.2) {
                self.minutesTF.isHidden = true
            }
        default:
            chooseImg3.image = UIImage(named: "choosed")
            UIView.animate(withDuration: 0.2) {
                self.minutesTF.isHidden = false
            }
            self.selectedTripSchedule = minutesTF.text
        }
        
    }
    
    @IBAction func confirmScheduleAction(_ sender: Any) {
        
        if let _ = selectedTripSchedule{
            
            let order = self.acceptedOrder
            
            var parameters: [String:Any] = [
                "from_lat": order?.trip?.fromLat ?? 0.0,
                "from_lng": order?.trip?.fromLng ?? 0.0,
                "to_lat": order?.trip?.toLat ?? 0.0,
                "to_lng": order?.trip?.toLng ?? 0.0,
                "address_from": order?.orderItems?.first?.restaurantName ?? "",
                "address_to": order?.address ?? "",
                "total": Double(order?.total ?? "0.0")! > 9999.0 ? 9999.0 : (order?.total ?? "0.0"),
                "lat": order?.lat ?? 0.0,
                "lng": order?.lng ?? 0.0,
                "ride_type": order?.trip?.rideType ?? 0
            ]
            
            if selectedTripSchedule! != "" && selectedTripSchedule != "15"{
                
                guard !minutesTF.text!.isEmpty else{
                    showAlert(title: "", message: "Select schedule option first")
                    return
                }
                
                parameters.updateValue(minutesTF.text!, forKey: "date")
                
                self.ordersPresenter?.scheduleTrip(id: self.acceptedOrderId!, parameters )
                
            }else{
                
                parameters.updateValue(selectedTripSchedule!, forKey: "date")
                
                self.ordersPresenter?.scheduleTrip(id: self.acceptedOrderId!,parameters)
            }
            
            print("parameters",parameters)
            
        }else{
          showAlert(title: "", message: "Select schedule option first")
        }
        
    }
    
    
    @objc func closeDrawer(){
        Drawer.close(drawerPosition, self)
    }

}

enum Orders{
    case new
    case old
}
