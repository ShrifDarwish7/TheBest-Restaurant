//
//  Categories.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/21/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

struct AllCategories: Codable {
    var MainCategories: [MainCategory]
}

struct SubCategories: Codable {
    var items: [MainCategory]
}

// MARK: - MainCategory
struct MainCategory: Codable {
    let id: Int
    let name: String
    let hasImage: String?
    let createdAt, updatedAt: String
    let typeId: Int?
    
    var selected: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name
        case hasImage = "has_image"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case typeId = "type_id"
        case selected
    }
}
