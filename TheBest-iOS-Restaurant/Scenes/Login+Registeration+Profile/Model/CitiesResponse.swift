//
//  CitiesResponse.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/22/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - CitiesResponse
struct CitiesResponse: Codable {
    let status: String
    let cities: [City]

    enum CodingKeys: String, CodingKey {
        case status
        case cities = "Cities"
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
