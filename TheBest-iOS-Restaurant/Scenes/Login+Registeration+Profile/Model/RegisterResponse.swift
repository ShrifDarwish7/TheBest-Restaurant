//
//  RegisterResponse.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/22/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - RegisterResponse
struct RegisterResponse: Codable {
    let massege: String?
    let restaurant: MyResturant?
    let updatedRestaurant: MyResturant?
    let accessToken: String?

    enum CodingKeys: String, CodingKey {
        case massege
        case restaurant = "Restaurant"
        case updatedRestaurant = "Restaurants"
        case accessToken
    }
}
