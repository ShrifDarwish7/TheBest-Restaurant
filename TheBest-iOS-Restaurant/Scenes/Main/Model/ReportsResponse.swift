//
//  ReportsResponse.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/17/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - ReportsResponse
struct ReportsResponse: Codable {
    let status: String
    let myOrders: [Order]
    let myOrdersCount, myOrdersDone, myOrdersCanceled, myOrdersMoney: Int

    enum CodingKeys: String, CodingKey {
        case status
        case myOrders = "MyOrders"
        case myOrdersCount = "MyOrdersCount"
        case myOrdersDone = "MyOrdersDone"
        case myOrdersCanceled = "MyOrdersCanceled"
        case myOrdersMoney = "MyOrdersMoney"
    }
}

