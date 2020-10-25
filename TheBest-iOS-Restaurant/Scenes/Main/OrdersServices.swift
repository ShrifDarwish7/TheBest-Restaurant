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
                
                do{
                    
                    let dataModel = try JSONDecoder.init().decode(OldOrdersReponse.self, from: data)
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
    
}
