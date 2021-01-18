//
//  AdditionalItemsResponse.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/26/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

struct AdditionalItemsResponse: Codable {
    let status: String
    let additionalItems: [AdditionalItem]
    
    enum CodingKeys: String, CodingKey {
        case status
        case additionalItems = "AdditionalItem"
    }
}

struct AdditionalItem: Codable {
    let id: Int
    let nameAr, nameEn, createdAt, updatedAt: String

    var selected: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
