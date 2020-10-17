//
//  RestaurantsInfo.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/17/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

struct RestaurantsInfo {
    var name: String
    var email: String
    var password: String
    var nameAr: String
    var nameEn: String
    var imagere: UIImage
    var description: String
    var descriptionEn: String
    var address: String
    var addressEn: String
    var categoryId: String
    var deliveryPrice: String
    var lat: String = "\(SharedData.userLat ?? 0.0)"
    var lng: String = "\(SharedData.userLng ?? 0.0)"
    var typeId: String
    var government: String
    var district: String
    var placeOwnerName: String
    var ownerImage: UIImage
    var imgCert: UIImage
    var placeEmail: String
    var signatureImage: UIImage
    var placePhone: String
    var orderLimit: String
    var branches: String
    var workingHours: String
    var timeFrame: String
    var responsibles: String
    var fcmToken: String
   
}
