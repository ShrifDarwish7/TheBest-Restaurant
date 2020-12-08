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


