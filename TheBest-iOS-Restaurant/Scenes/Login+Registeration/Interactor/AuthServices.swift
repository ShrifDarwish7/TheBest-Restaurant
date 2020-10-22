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
    var myRestaurant: MyResturant{
        get{
            return try! JSONDecoder().decode(MyResturant.self, from: defaults.object(forKey: "myRestaurant") as? Data ?? Data())
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
            multipartFormData.append(restaurantsInfo.address.data(using: String.Encoding.utf8)!, withName: "address")
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
            
        }, to: URL(string: REGISTER_API)!, method: .post, headers: HEADERS) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("RegisterResponse",try? JSON(data: data))
                        
                        do{
                            
                            let dataModel = try JSONDecoder().decode(RegisterResponse.self, from: data)
                            self.instance.myRestaurant = dataModel.restaurant
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
    
    static func getMainCategories(completed: @escaping (AllCategories?)->Void){
            
        Alamofire.request(URL(string: RESTAURANTS_CATEGORIES_API)!, method: .get, parameters: nil, headers: SharedData
            .headers).responseData { (response) in

            switch response.result{

            case .success(let data):

                do {
                    let dataModel = try JSONDecoder().decode(AllCategories.self, from: data)
                    print("mainCATs",dataModel)
                    completed(dataModel)
                } catch let error {
                    print("parseErr",error)
                    completed(nil)
                }

            case .failure(_):

                completed(nil)

            }

        }
        
    }
    
    static func getCategoriesBy(id: Int, completed: @escaping (SubCategories?)->Void){
              
        Alamofire.request(URL(string: CATEGORIES_BY_ID_API + "\(id)")!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in

            switch response.result{

            case .success(let data):

                print("here",try! JSON(data: data))

                do {
                    let dataModel = try JSONDecoder().decode(SubCategories.self, from: data)
                    print("SubCATs",dataModel)
                    completed(dataModel)
                } catch let error {
                    print("parseErr",error)
                    completed(nil)
                }

            case .failure(_):

                completed(nil)

            }

        }
        
    }
    
    static func getAllCities(_ completed: @escaping (CitiesResponse?)->Void){
        
        let headers = [
            "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNWU0OGJjNjQwMzU3NTdiZGVmNjdkYjZhODNjODg2NGEzNmFkMzdlYThhNDQwMzdlMDlhMjU1MjE5NzE0ZWFiMDZmN2NmYTE0YjgyNmNkNmIiLCJpYXQiOjE2MDE3NDc1NDYsIm5iZiI6MTYwMTc0NzU0NiwiZXhwIjoxNjMzMjgzNTQ2LCJzdWIiOiIxNjAiLCJzY29wZXMiOltdfQ.IvFjhBE6o8BznywCN_atolCLmlgMZ98fZLwCXMMlZXFF008pea-wEPpHw7HC5AMEgO4jt4OwTe7r4f7lSNy9JJLA0hSrlgJm9XSlnULVq2dnNuMDnui8B9RwGkpHVUJbnCcosPTtDusdnPkYqRpmSdhHYawjMNUCDQDhaC_UdL13Baxp02Kz6fH6Yu7MCcH52rl-9RVCo3I_dg3ujVSz0E5MzVX6nhwVxXcsew3X4qr9Ga9J65Tw0rDOG7zKT2i0H0QKPN0Wi5s9XqiMzEyfQuOyP0g9laDHqtHCK-QFrb-CGTVYK0Yhsne8nZHDAnAfepML7wW60syHHTM8sZFTlNN4lKQLni-HUEKiiCdf_fgaR2INDGqTlyLPJV49CL3m61QG_vPVS-PUs_f41k_hKh36YN1lmNDRSmFPD3OK_IKeVLp_wK0ist0vW55hYDoRBVXxHiID2Kowp9VStrIu7c3XbbJyvddd-WJCu5QHEbxFAMxtW5mwGvj4MIgBSBnrzvPAlqZGRJnoXYx9WjucpahCbKFZbLVnVlOo6uKeqVjJJM85QD8vrQOcMPO4dIyy8AsG0k_lHQ-eQ952vDJVTjHtIGyVJXAg0oou9rAr6jFQcKbvHKkpdKSK4515HGZY2sxOiaFc3yoKL74zM0BdPVY3SFBMPrgDAxD2XuhTuJI",
            "Accept": "application/json"
        ]
        
        Alamofire.request(ALL_CITIES_API, method: .get, parameters: nil, headers: headers).responseData { (response) in
            switch response.result{
            case .success(let data):
                do{
                    let dataModel = try JSONDecoder().decode(CitiesResponse.self, from: data)
                    completed(dataModel)
                }catch let err{
                    print(err)
                    completed(nil)
                }
            case .failure(_):
                completed(nil)
            }
        }
        
    }
    
    static func getDistrictBy(_ id: Int, _ completed: @escaping (DistrictsResponse?)->Void){
        
        let headers = [
            "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNWU0OGJjNjQwMzU3NTdiZGVmNjdkYjZhODNjODg2NGEzNmFkMzdlYThhNDQwMzdlMDlhMjU1MjE5NzE0ZWFiMDZmN2NmYTE0YjgyNmNkNmIiLCJpYXQiOjE2MDE3NDc1NDYsIm5iZiI6MTYwMTc0NzU0NiwiZXhwIjoxNjMzMjgzNTQ2LCJzdWIiOiIxNjAiLCJzY29wZXMiOltdfQ.IvFjhBE6o8BznywCN_atolCLmlgMZ98fZLwCXMMlZXFF008pea-wEPpHw7HC5AMEgO4jt4OwTe7r4f7lSNy9JJLA0hSrlgJm9XSlnULVq2dnNuMDnui8B9RwGkpHVUJbnCcosPTtDusdnPkYqRpmSdhHYawjMNUCDQDhaC_UdL13Baxp02Kz6fH6Yu7MCcH52rl-9RVCo3I_dg3ujVSz0E5MzVX6nhwVxXcsew3X4qr9Ga9J65Tw0rDOG7zKT2i0H0QKPN0Wi5s9XqiMzEyfQuOyP0g9laDHqtHCK-QFrb-CGTVYK0Yhsne8nZHDAnAfepML7wW60syHHTM8sZFTlNN4lKQLni-HUEKiiCdf_fgaR2INDGqTlyLPJV49CL3m61QG_vPVS-PUs_f41k_hKh36YN1lmNDRSmFPD3OK_IKeVLp_wK0ist0vW55hYDoRBVXxHiID2Kowp9VStrIu7c3XbbJyvddd-WJCu5QHEbxFAMxtW5mwGvj4MIgBSBnrzvPAlqZGRJnoXYx9WjucpahCbKFZbLVnVlOo6uKeqVjJJM85QD8vrQOcMPO4dIyy8AsG0k_lHQ-eQ952vDJVTjHtIGyVJXAg0oou9rAr6jFQcKbvHKkpdKSK4515HGZY2sxOiaFc3yoKL74zM0BdPVY3SFBMPrgDAxD2XuhTuJI",
            "Accept": "application/json"
        ]
        
        Alamofire.request(DISTRICTS_API + "\(id)", method: .get, parameters: nil, headers: headers).responseData { (response) in
            switch response.result{
            case .success(let data):
                do{
                    let dataModel = try JSONDecoder().decode(DistrictsResponse.self, from: data)
                    completed(dataModel)
                }catch let err{
                    print(err)
                    completed(nil)
                }
            case .failure(_):
                completed(nil)
            }
        }
        
    }
    
}
