//
//  OldOrders.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/17/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - OldOrdersReponse
struct OldOrdersReponse: Codable {
    let status: String
    let oldOrders: [Order]

    enum CodingKeys: String, CodingKey {
        case status
        case oldOrders = "OldOrders"
    }
}

// MARK: - OldOrder
struct Order: Codable {
    let id: Int
    let username: String
    let userID: Int
    let lat, lng: Double
    let comment, address, phone, total: String
    let status: String
    let catID, driverID: String?
    let userParent: Int
    let createdAt, updatedAt: String
    let orderItems: [OrderItem]
    
    var expanded: Bool?
        
    enum CodingKeys: String, CodingKey {
        case id, username
        case userID = "user_id"
        case lat, lng, comment, address, phone, total, status
        case catID = "cat_id"
        case driverID = "driver_id"
        case userParent = "user_parent"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case orderItems = "order_items"
    }
}

// MARK: - OrderItem
struct OrderItem: Codable {
    let id, itemID, placeID, orderID: Int
    let count, variationID: Int

    enum CodingKeys: String, CodingKey {
        case id
        case itemID = "item_id"
        case placeID = "place_id"
        case orderID = "order_id"
        case count
        case variationID = "variation_id"
    }
}
