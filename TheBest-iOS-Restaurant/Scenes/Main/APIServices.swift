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
    
    static func getMenuItems(_ id: Int, completed: @escaping (_ dataModel: inout [RestaurantMenuItem])->Void, failed: @escaping (Bool)->Void){
        Alamofire.request(URL(string: MENU_ITEMS_API + "\(id)")!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
           switch response.result{
            case .success(let data):
                
                do{
                    
                    var dataModel = try JSONDecoder.init().decode(RestaurantMenuItemsResponse.self, from: data)
                    if !dataModel.restaurantMenu.isEmpty{
                        completed(&dataModel.restaurantMenu)
                    }else{
                        failed(true)
                    }
                    
                }catch let error{
                    print("errPars",error)
                    failed(true)
                }
            case .failure(let error):
                print("err",error)
                failed(true)
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
    
    static func addProduct(_ parameters: [String:String],_ image: UIImage, completed: @escaping (Bool)->Void){
        
        URLCache.shared.removeAllCachedResponses()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key,value) in parameters{
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
            multipartFormData.append(image.jpegData(compressionQuality: 0.2)!, withName: "image", mimeType: "image/jpg")

        }, to: URL(string: ADD_PRODUCTS_API)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("addProdiuctResponse",try? JSON(data: data))
                        
                        if JSON(data)["status"].stringValue == "200"{
                            completed(true)
                        }else{
                            completed(false)
                        }
                        
                    case .failure(let error):
                        
                        print("addProdiuctParseError",error)
                        completed(false)
                        
                    }
                    
                }
                
            case .failure(let error):
                
                print("error",error)
                completed(false)
                
            }
            
        }
        
    }
    
    static func updateProduct(_ id: Int, _ parameters: [String:String], _ image: UIImage?, completed: @escaping (Bool)->Void){
        
        URLCache.shared.removeAllCachedResponses()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key,value) in parameters{
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
            
            if let image = image{
                multipartFormData.append(image.jpegData(compressionQuality: 0.2)!, withName: "image", mimeType: "image/jpg")
            }

        }, to: URL(string: UPDATE_PRODUCT_API + "\(id)")!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("updateProdiuctResponse",try? JSON(data: data))
                        
                        if JSON(data)["status"].stringValue == "200"{
                            completed(true)
                        }else{
                            completed(false)
                        }
                        
                    case .failure(let error):
                        
                        print("updateProdiuctParseError",error)
                        completed(false)
                        
                    }
                    
                }
                
            case .failure(let error):
                
                print("error",error)
                completed(false)
                
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
    
    static func getAdditionalItems(completed: @escaping (AdditionalItemsResponse?)->Void){
        Alamofire.request(URL(string: ADDITIONAL_ITEMS_API)!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
            switch response.result{
            case .success(let data):
                
                do{
                    
                    let dataModel = try JSONDecoder.init().decode(AdditionalItemsResponse.self, from: data)
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
    
    static func deleteProduct(_ id: String, completed: @escaping (Bool)->Void){
        
        URLCache.shared.removeAllCachedResponses()
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
        
            
        }, to: URL(string: DELETE_PRODUCT_API + id)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("prodDeleted",try? JSON(data: data))
                        
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
    
    static func deleteMenu(_ id: String, completed: @escaping (Bool)->Void){
        
        URLCache.shared.removeAllCachedResponses()
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
        
            
        }, to: URL(string: DELETE_MENU_API + id)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("menuDeleted",try? JSON(data: data))
                        
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
    
    static func updateMenu(_ id: String,_ name: String, completed: @escaping (Bool)->Void){
        
        URLCache.shared.removeAllCachedResponses()
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
        
            multipartFormData.append(name.data(using: String.Encoding.utf8)!, withName: "name")
            
        }, to: URL(string: UPDATE_MENU_API + id)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("menuUpdated",try? JSON(data: data))
                        
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
