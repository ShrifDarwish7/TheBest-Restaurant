//
//  MapVC.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 21/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import GoogleMaps

class MapVC: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var ordersPresenter: OrdersPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ordersPresenter = OrdersPresenter(self)
        ordersPresenter?.getNewOrers()
        
        mapView.delegate = self

    }
    
    @IBAction func popAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension MapVC: GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        NotificationCenter.default.post(name: NSNotification.Name("OpenOrder"), object: nil, userInfo: nil)
        return true
    }
}
