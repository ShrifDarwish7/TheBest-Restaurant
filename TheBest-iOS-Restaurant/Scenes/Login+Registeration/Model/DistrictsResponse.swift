//
//  DistrictsResponse.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/22/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - DistrictsResponse
struct DistrictsResponse: Codable {
    let status: String
    let districts: [District]

    enum CodingKeys: String, CodingKey {
        case status
        case districts = "Districts"
    }
}

// MARK: - District
struct District: Codable {
    let id: Int
    let name: String
    let cityID: Int
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case cityID = "city_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
