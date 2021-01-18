//
//  MyMenusResponse.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/17/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - MyMenusResponse
struct MyMenusResponse: Codable {
    let status: Int
    let myMenus: [MyMenu]

    enum CodingKeys: String, CodingKey {
        case status
        case myMenus = "MyMenus"
    }
}

// MARK: - MyMenu
struct MyMenu: Codable {
    let id: Int
    let name: String
    let restaurantID, catID: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case restaurantID = "restaurant_id"
        case catID = "cat_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
