//
//  AuthServices.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/17/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthServices{
    
    static let instance = AuthServices()
    let defaults = UserDefaults.standard
    var isLogged: Bool{
        set{
            self.defaults.set(newValue, forKey: "isLogged")
        }
        get{
            return self.defaults.bool(forKey: "isLogged")
        }
    }
    var myRestaurant: Myresturant{
        get{
            return try! JSONDecoder().decode(Myresturant.self, from: defaults.object(forKey: "myRestaurant") as? Data ?? Data())
        }
        set{
            let userEncoded = try! JSONEncoder().encode(newValue)
            self.defaults.set(userEncoded, forKey: "myRestaurant")
        }
    }
    
    static func loginWith(_ email: String, _ password: String, _ fcmToken: String, completed: @escaping (Bool)->Void){
        URLCache.shared.removeAllCachedResponses()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(email.data(using: String.Encoding.utf8)!, withName: "email")
            multipartFormData.append(password.data(using: String.Encoding.utf8)!, withName: "password")
            multipartFormData.append(fcmToken.data(using: String.Encoding.utf8)!, withName: "fcm_token")
            
        }, to: URL(string: LOGIN_API)!, method: .post, headers: HEADERS) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("myRestaurant",try? JSON(data: data))
                        
                        do{
                            
                            let dataModel = try JSONDecoder().decode(LoginResponse.self, from: data)
                            self.instance.myRestaurant = dataModel.myresturant
                            UserDefaults.init().set(JSON(data)["accessToken"].stringValue, forKey: "accessToken")
                            print(dataModel)
                            self.instance.isLogged = true
                            completed(true)
                            
                        }catch let error{
                            print("parsErrr",error)
                            self.instance.isLogged = false
                            completed(false)
                        }
                        
                    case .failure(let error):
                        
                        print("userParseError",error)
                        completed(false)
                        
                    }
                    
                }
                
            case .failure(let error):
                
                print("error",error)
                self.instance.isLogged = false
                completed(false)
                
            }
            
        }
    
    }
    
    static func registerWith(restaurantsInfo: RestaurantsInfo, completed: @escaping (Bool)->Void){
        
        URLCache.shared.removeAllCachedResponses()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
           multipartFormData.append(restaurantsInfo.imagere.jpegData(compressionQuality: 0.2)!, withName: "imagere", mimeType: "imagere/jpg")
            multipartFormData.append(restaurantsInfo.ownerImage.jpegData(compressionQuality: 0.2)!, withName: "ownerimage", mimeType: "ownerimage/jpg")
            multipartFormData.append(restaurantsInfo.imgCert.jpegData(compressionQuality: 0.2)!, withName: "imgcert", mimeType: "imgcert/jpg")
            multipartFormData.append(restaurantsInfo.signatureImage.jpegData(compressionQuality: 0.2)!, withName: "signatureimage", mimeType: "signatureimage/jpg")
            multipartFormData.append(restaurantsInfo.name.data(using: String.Encoding.utf8)!, withName: "name")
             multipartFormData.append(restaurantsInfo.nameAr.data(using: String.Encoding.utf8)!, withName: "name_ar")
             multipartFormData.append(restaurantsInfo.nameEn.data(using: String.Encoding.utf8)!, withName: "name_en")
            multipartFormData.append(restaurantsInfo.email.data(using: String.Encoding.utf8)!, withName: "email")
            multipartFormData.append(restaurantsInfo.password.data(using: String.Encoding.utf8)!, withName: "password")
            multipartFormData.append(restaurantsInfo.fcmToken.data(using: String.Encoding.utf8)!, withName: "fcm_token")
            multipartFormData.append(restaurantsInfo.placePhone.data(using: String.Encoding.utf8)!, withName: "place_phone")
            multipartFormData.append(restaurantsInfo.lat.data(using: String.Encoding.utf8)!, withName: "lat")
            multipartFormData.append(restaurantsInfo.lng.data(using: String.Encoding.utf8)!, withName: "lng")
            multipartFormData.append(restaurantsInfo.address.data(using: String.Encoding.utf8)!, withName: "address") // from google maps api
            multipartFormData.append(restaurantsInfo.description.data(using: String.Encoding.utf8)!, withName: "description")
            multipartFormData.append(restaurantsInfo.descriptionEn.data(using: String.Encoding.utf8)!, withName: "description_en")
            multipartFormData.append(restaurantsInfo.addressEn.data(using: String.Encoding.utf8)!, withName: "address_en")
            multipartFormData.append(restaurantsInfo.categoryId.data(using: String.Encoding.utf8)!, withName: "category_id")
            multipartFormData.append(restaurantsInfo.deliveryPrice.data(using: String.Encoding.utf8)!, withName: "delivery_price")
            multipartFormData.append(restaurantsInfo.typeId.data(using: String.Encoding.utf8)!, withName: "type_id")
            multipartFormData.append(restaurantsInfo.government.data(using: String.Encoding.utf8)!, withName: "government")
            multipartFormData.append(restaurantsInfo.district.data(using: String.Encoding.utf8)!, withName: "district")
            multipartFormData.append(restaurantsInfo.placeOwnerName.data(using: String.Encoding.utf8)!, withName: "place_owner_name")
            multipartFormData.append(restaurantsInfo.placeEmail.data(using: String.Encoding.utf8)!, withName: "place_email")
            multipartFormData.append(restaurantsInfo.orderLimit.data(using: String.Encoding.utf8)!, withName: "order_limit")
            multipartFormData.append(restaurantsInfo.branches.data(using: String.Encoding.utf8)!, withName: "branches")
            multipartFormData.append(restaurantsInfo.workingHours.data(using: String.Encoding.utf8)!, withName: "working_hours")
            multipartFormData.append(restaurantsInfo.timeFrame.data(using: String.Encoding.utf8)!, withName: "time_frame")
            multipartFormData.append(restaurantsInfo.responsibles.data(using: String.Encoding.utf8)!, withName: "responsibles")
            
        }, to: URL(string: LOGIN_API)!, method: .post, headers: HEADERS) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("user",try? JSON(data: data))
                        
                        do{
                            
                            let dataModel = try JSONDecoder().decode(LoginResponse.self, from: data)
                            self.instance.myRestaurant = dataModel.myresturant
                            UserDefaults.init().set(JSON(data)["accessToken"].stringValue, forKey: "accessToken")
                            print(dataModel)
                            self.instance.isLogged = true
                            completed(true)
                            
                        }catch let error{
                            print("parsErrr",error)
                            self.instance.isLogged = false
                            completed(false)
                        }
                        
                    case .failure(let error):
                        
                        print("userParseError",error)
                        completed(false)
                        
                    }
                    
                }
                
            case .failure(let error):
                
                print("error",error)
                self.instance.isLogged = false
                completed(false)
                
            }
            
        }
    
    }
    
    
}
