//
//  RestaurantMenuItemsResponse.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/17/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - RestaurantMenuItemsResponse
struct RestaurantMenuItemsResponse: Codable {
    let restaurantMenu: [RestaurantMenuItem]

    enum CodingKeys: String, CodingKey {
        case restaurantMenu = "RestaurantMenu"
    }
}

// MARK: - RestaurantMenu
struct RestaurantMenuItem: Codable {
    let id: Int
    let name, nameEn, price, image: String
    let restaurantMenuDescription, descriptionEn: String
    let restaurantID: Int
    let menuCategoryID, attributeTitle: String
    let attributeTitleTwo, attributeTitleThree: String?
    let attributeTitleEn: String
    let attributeTitleEnTwo, attributeTitleEnThree: String?
    let attributeBody: String
    let attributeBodyTwo: String?
    let attributeBodyThree: String
    let additionalItemAr: String?
    let additionalItemEn, catID, createdAt, updatedAt: String
    let hasImage: String
    let itemattributes: [String]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case nameEn = "name_en"
        case price, image
        case restaurantMenuDescription = "description"
        case descriptionEn = "description_en"
        case restaurantID = "restaurant_id"
        case menuCategoryID = "menu_category_id"
        case attributeTitle = "attribute_title"
        case attributeTitleTwo = "attribute_title_two"
        case attributeTitleThree = "attribute_title_three"
        case attributeTitleEn = "attribute_title_en"
        case attributeTitleEnTwo = "attribute_title_en_two"
        case attributeTitleEnThree = "attribute_title_en_three"
        case attributeBody = "attribute_body"
        case attributeBodyTwo = "attribute_body_two"
        case attributeBodyThree = "attribute_body_three"
        case additionalItemAr = "additional_item_ar"
        case additionalItemEn = "additional_item_en"
        case catID = "cat_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case hasImage = "has_image"
        case itemattributes
    }
}
