//
//  APIServices.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/17/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIServices{
    
    static func getMenus(completed: @escaping (MyMenusResponse?)->Void){
        Alamofire.request(URL(string: MENUS_API)!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
            switch response.result{
            case .success(let data):
                
                do{
                    
                    let dataModel = try JSONDecoder.init().decode(MyMenusResponse.self, from: data)
                    completed(dataModel)
                    
                }catch let error{
                    print("errPars",error)
                    completed(nil)
                }
            case .failure(let error):
                print("err",error)
                completed(nil)
            }
        }
    }
    
    static func getMyPlace(completed: @escaping (MyResturant?)->Void){
        Alamofire.request(URL(string: PLACE_API)!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
            switch response.result{
            case .success(let data):
                
                do{
                    
                    let dataModel = try JSONDecoder.init().decode(MyPlace.self, from: data)
                    completed(dataModel.myResturant)
                    
                }catch let error{
                    print("errPars",error)
                    completed(nil)
                }
            case .failure(let error):
                print("err",error)
                completed(nil)
            }
        }
    }
    
    static func changeOrderStatus(completed: @escaping (Bool)->Void){
        Alamofire.request(URL(string: CHANGE_ORDER_STATUS)!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
            switch response.result{
            case .success(let data):
                
                do{
                    
                    let json = try JSON(data: data)
                    
                    if json["status"].stringValue == "200"{
                        completed(true)
                    }else{
                        completed(false)
                    }
                    
                }catch let error{
                    print("errPars",error)
                    completed(false)
                }
            case .failure(let error):
                print("err",error)
                completed(false)
            }
        }
    }
    
    static func getMenuItems(completed: @escaping ([RestaurantMenuItem]?)->Void){
        Alamofire.request(URL(string: MENU_ITEMS_API)!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
           switch response.result{
            case .success(let data):
                
                do{
                    
                    let dataModel = try JSONDecoder.init().decode(RestaurantMenuItemsResponse.self, from: data)
                    completed(dataModel.restaurantMenu)
                    
                }catch let error{
                    print("errPars",error)
                    completed(nil)
                }
            case .failure(let error):
                print("err",error)
                completed(nil)
            }
        }
    }
    
    static func getRestaurantsReports(_ from: String,_ to: String, completed: @escaping (ReportsResponse?)->Void){
        
        URLCache.shared.removeAllCachedResponses()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
        
            multipartFormData.append(from.data(using: String.Encoding.utf8)!, withName: "from_date")
            multipartFormData.append(to.data(using: String.Encoding.utf8)!, withName: "to_date")
            
        }, to: URL(string: REPORTS_API)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("reports",try? JSON(data: data))
                        
                        if JSON(data)["status"].intValue == 200{
                            
                            do{
                                
                                let dataModel = try JSONDecoder().decode(ReportsResponse.self, from: data)
                                print(dataModel)
                                completed(dataModel)
                                
                            }catch let error{
                                print("parsErrr",error)
                                completed(nil)
                            }
                            
                        }else{
                            completed(nil)
                        }
                        
                    case .failure(let error):
                        
                        print("reportsParseError",error)
                        completed(nil)
                        
                    }
                    
                }
                
            case .failure(let error):
                
                print("error",error)
                completed(nil)
                
            }
            
        }
        
    }
    
    static func addProduct(_ product: Product, completed: @escaping (ReportsResponse?)->Void){
        
        URLCache.shared.removeAllCachedResponses()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
        
            multipartFormData.append(product.attribute_body.data(using: String.Encoding.utf8)!, withName: "attribute_body")
            multipartFormData.append(product.attribute_title_ar.data(using: String.Encoding.utf8)!, withName: "attribute_title_ar")
            multipartFormData.append(product.attribute_title_en.data(using: String.Encoding.utf8)!, withName: "attribute_title_en")
            multipartFormData.append(product.cat_id.data(using: String.Encoding.utf8)!, withName: "cat_id")
            multipartFormData.append(product.description_ar.data(using: String.Encoding.utf8)!, withName: "description_ar")
            multipartFormData.append(product.description_en.data(using: String.Encoding.utf8)!, withName: "description_en")
            multipartFormData.append(product.image.jpegData(compressionQuality: 0.2)!, withName: "image", mimeType: "image/jpg")
            multipartFormData.append(product.menu_category_id.data(using: String.Encoding.utf8)!, withName: "menu_category_id")
            multipartFormData.append(product.name_ar.data(using: String.Encoding.utf8)!, withName: "name_ar")
            multipartFormData.append(product.name_en.data(using: String.Encoding.utf8)!, withName: "name_en")
            multipartFormData.append(product.price.data(using: String.Encoding.utf8)!, withName: "price")
            multipartFormData.append(product.restaurant_id.data(using: String.Encoding.utf8)!, withName: "restaurant_id")

            
        }, to: URL(string: ADD_PRODUCTS_API)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("reports",try? JSON(data: data))
                        
                        if JSON(data)["status"].intValue == 200{
                            
                            do{
                             
                                
                                
                            }catch let error{
                                print("parsErrr",error)
                                completed(nil)
                            }
                            
                        }else{
                            completed(nil)
                        }
                        
                    case .failure(let error):
                        
                        print("reportsParseError",error)
                        completed(nil)
                        
                    }
                    
                }
                
            case .failure(let error):
                
                print("error",error)
                completed(nil)
                
            }
            
        }
        
    }
    
    static func addMenu(_ name: String, completed: @escaping (Bool)->Void){
        
        URLCache.shared.removeAllCachedResponses()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
        
            multipartFormData.append(name.data(using: String.Encoding.utf8)!, withName: "name")
            
        }, to: URL(string: ADD_MENU_API)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("menuAdded",try? JSON(data: data))
                        
                        if JSON(data)["status"].stringValue == "200"{
                            completed(true)
                        }else{
                            completed(false)
                        }
                        
                    case .failure(let error):
                        
                        print("ParseError",error)
                        completed(false)
                        
                    }
                    
                }
                
            case .failure(let error):
                
                print("error",error)
                completed(false)
                
            }
            
        }
        
    }
    
}
