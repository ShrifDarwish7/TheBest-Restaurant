//
//  LoginResponse.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/17/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let myresturant: MyResturant
    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case myresturant = "Myresturant"
        case accessToken
    }
}

// MARK: - Myresturant
struct MyResturant: Codable {
    let id: Int
    let name, nameEn: String
    let image: String?
    let myresturantDescription, descriptionEn, address, addressEn: String
    let categoryID: String
  //  let deliveryPrice: Int?
  //  let lat, lng: Double
    let typeID, parentUser: Int
    let country, government, district, placeOwnerName: String
    let ownerimage, imgcert: String?
    let placeEmail: String
    let signatureimage: String?
    let placePhone: String
    let bankingID: String?
   // let orderLimit: Int
    let branches, workingHours, timeFrame, responsibles: String
    let createdAt, updatedAt: String

    var decodedBranches: [Branch]?
    var decodedWorkingHours: [WorkingHours]?
    var decodedResponsibles: [Responsible]?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case nameEn = "name_en"
        case image
        case myresturantDescription = "description"
        case descriptionEn = "description_en"
        case address
        case addressEn = "address_en"
        case categoryID = "category_id"
     //   case deliveryPrice = "delivery_price"
     //   case lat, lng
        case typeID = "type_id"
        case parentUser = "parent_user"
        case country, government, district
        case placeOwnerName = "place_owner_name"
        case ownerimage, imgcert
        case placeEmail = "place_email"
        case signatureimage
        case placePhone = "place_phone"
        case bankingID = "banking_id"
       // case orderLimit = "order_limit"
        case branches
        case workingHours = "working_hours"
        case timeFrame = "time_frame"
        case responsibles
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
