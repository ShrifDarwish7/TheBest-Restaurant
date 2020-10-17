//
//  MyPlace.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/17/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

struct MyPlace: Codable {
    let myResturant: MyResturant
    enum CodingKeys: String, CodingKey {
        case myResturant = "MyRestaurant"
    }
}
