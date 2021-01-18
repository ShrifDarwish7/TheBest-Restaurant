//
//  OrdersServices.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/17/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class OrdersServices{
    
    static func getOldOrders(completed: @escaping (OldOrdersReponse?)->Void){
        Alamofire.request(URL(string: OLD_ORDERS_API)!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
            switch response.result{
            case .success(let data):
                print(JSON(data))
                if JSON(data)["OldOrders"].stringValue == "There are no Old Orders"{
                    completed(nil)
                }else{
                    do{
                        
                        let dataModel = try JSONDecoder.init().decode(OldOrdersReponse.self, from: data)
                        completed(dataModel)
                        
                    }catch let error{
                        print("errPars",error)
                        completed(nil)
                    }
                }                
            case .failure(let error):
                print("err",error)
                completed(nil)
            }
        }
    }
    
    static func getNewOrders(completed: @escaping (NewOrdersResponse?)->Void){
        Alamofire.request(URL(string: NEW_ORDERS_API)!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
            switch response.result{
            case .success(let data):
                
                if JSON(data)["OldOrders"].stringValue == "There are no New Orders"{
                    completed(nil)
                }else{
                    do{
                        
                        let dataModel = try JSONDecoder.init().decode(NewOrdersResponse.self, from: data)
                        completed(dataModel)
                        
                    }catch let error{
                        print("errPars",error)
                        completed(nil)
                    }
                }
            case .failure(let error):
                print("err",error)
                completed(nil)
            }
        }
    }
     
    static func changeOrderStatus(id: String, status: String, completed: @escaping (Bool)->Void){
        Alamofire.upload(multipartFormData: { (multipart) in
            multipart.append(status.data(using: .utf8)!, withName: "status")
        }, to: CHANGE_ORDER_STATUS_API+id, method: .post, headers: SharedData.headers) { (encodingResult) in
            switch encodingResult{
            case.success(request: let request,_,_):
                request.responseData { (response) in
                    switch response.result{
                    case .success(let data):
                        
                        do{
                            
                            let json = try JSON(data: data)
                            print(json)
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
            default:
                break
            }
        }
    }
    
    static func scheduleTripWith(_ parameters: [String:Any],id: String, completed: @escaping (Bool)->Void){
        Alamofire.upload(multipartFormData: { (multipart) in
            //multipart.append(date.data(using: .utf8)!, withName: "date")
            for (key,value) in parameters{
                multipart.append("\(value)".data(using: .utf8)!, withName: key)
            }
        }, to: SCHEDULE_TRIP_API+id, method: .post, headers: SharedData.headers) { (encodingResult) in
            switch encodingResult{
            case.success(request: let request,_,_):
                request.responseData { (response) in
                    switch response.result{
                    case .success(let data):
                        
                        do{
                            
                            let json = try JSON(data: data)
                            print(json)

                            if json["message"].stringValue == "Done"{
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
            default:
                break
            }
        }
    }
    
}
