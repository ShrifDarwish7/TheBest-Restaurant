//
//  SharedData.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/17/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import CoreLocation

class SharedData{
    
    static let goolgeApiKey = "AIzaSyDBDV-XxFpmbx79T5HLPrG9RmjDpiYshmE"
    static var userLat: CLLocationDegrees?
    static var userLng: CLLocationDegrees?
    static var selectedRegisteredCategoriesIDs = [Int]()
    static var selectedRegisteredCategoriesNames = [String]()
    static var selectedRegisteredCityID: Int?
    static var selectedRegisteredDistrictID: Int?
    static var orderInProgress = "in progress"
    static var receivedPushNotification: [AnyHashable: Any]?
    static let headers = [
        "Authorization": "Bearer " + (UserDefaults.init().string(forKey: "accessToken") ?? ""),
        "Accept": "application/json"
    ]
    
}
