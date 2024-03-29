//
//  APIs.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/17/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

let BASE_URL = "https://thebest-solution.com/"
let LOGIN_API = BASE_URL + "Restaurants/Auth/login"
let REGISTER_API = BASE_URL + "Restaurants/Auth/register"
let CATEGORIES_BY_ID_API = BASE_URL + "Restaurants/Main/CategoryById/"
let RESTAURANTS_CATEGORIES_API = BASE_URL + "Restaurants/Main/AllCategories"
let OLD_ORDERS_API = BASE_URL + "Restaurants/Main/OldOrders"
let MENUS_API = BASE_URL + "Restaurants/Main/MyMenus"
let NEW_ORDERS_API = BASE_URL + "Restaurants/Main/NewOrders"
let PLACE_API = BASE_URL + "Restaurants/Main/MyPlace"
let MENU_ITEMS_API = BASE_URL + "Restaurants/Main/MenuItems/"
let REPORTS_API = BASE_URL + "Restaurants/Main/RestaurantsReports"
let ADD_PRODUCTS_API = BASE_URL + "Restaurants/Main/AddProduct"
let ADD_MENU_API = BASE_URL + "Restaurants/Main/AddMenu"
let ALL_CITIES_API = BASE_URL + "Restaurants/Main/allCities"
let DISTRICTS_API = BASE_URL + "Restaurants/Main/DistrictsById/"
let ADDITIONAL_ITEMS_API = BASE_URL + "Restaurants/Main/AddtionalItems"
let UPDATE_PRODUCT_API = BASE_URL + "Restaurants/Main/UpdateProduct/"
let DELETE_PRODUCT_API = BASE_URL + "Restaurants/Main/DeleteProduct/"
let DELETE_MENU_API = BASE_URL + "Restaurants/Main/DeleteMenu/"
let UPDATE_MENU_API = BASE_URL + "Restaurants/Main/UpdateMenu/"
let UPDATE_PROFILR_API = BASE_URL + "Restaurants/Main/UpdateProfile"
let CHANGE_ORDER_STATUS_API = BASE_URL + "Restaurants/Main/ChangeOrderStatus/"
let SCHEDULE_TRIP_API = BASE_URL + "api/Trip/ScheduleTrip/"

let HEADERS = ["Accept": "application/json"]
