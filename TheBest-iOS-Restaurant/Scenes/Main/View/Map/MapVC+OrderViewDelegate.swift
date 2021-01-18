//
//  MapVC+OrderViewDelegate.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 21/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD
import GoogleMaps

extension MapVC: OrdersViewDelegate{
    func SVProgressStatus(_ show: Bool) {
        if show{
            SVProgressHUD.show()
        }else{
            SVProgressHUD.dismiss()
        }
    }
    func didCompleteWith(_ orders: [Order]?) {
        if let orders = orders{
            for order in orders{
                if let trip = order.trip,
                   let lat = trip.fromLat,
                   let lng = trip.toLng
                {
                    let marker = GMSMarker()
                    //marker.icon = Images.imageWithImage(image: UIImage(named: "car-marker")!, scaledToSize: CGSize(width: 40, height: 55))
                    marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                   // self.mapView.camera = GMSCameraPosition(latitude: lat, longitude: lat, zoom: 15)
                    let view = MarkerView(frame: CGRect(x: 0, y: 0, width: 300, height: 220))
                   // view.order = order
                    view.loadOrderInfo(order: order)
                    marker.iconView = view
                    marker.map = mapView
                    
                }
            }
        }
    }
}
