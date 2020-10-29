//
//  Router.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/3/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

class Router{
    
    static func toLoginVC(_ sender: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        sender.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func toSignUp(_ sender: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        sender.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func toHome(_ sender: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        sender.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func toCategories(_ sender: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CategoriesVC") as! CategoriesVC
        sender.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func toOrders(_ sender: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OrdersVC") as! OrdersVC
        sender.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func toChooseCategory(_ sender: UIViewController, _ chooserType: ChooserType, cityID: Int?, menuID: Int?){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChooseCategoryVC") as! ChooseCategoryVC
        vc.chooserType = chooserType
        if let _ = cityID{
            vc.receivedCityId = cityID
        }
        if let _ = menuID{
            vc.receivedMenuID = menuID
        }
        sender.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func toChooseSubCategory(_ id: Int, _ sender: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChooseSubCategoryVC") as! ChooseSubCategoryVC
        vc.receivedId = id
        sender.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func toReports(_ sender: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ReportsVC") as! ReportsVC
        sender.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func toProduct(_ sender: UIViewController,_ item: RestaurantMenuItem?, viewState: VCState){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
        vc.itemReceived = item
        vc.viewState = viewState
        sender.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func toMyRestaurant(_ sender: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        vc.pageType = .Profile
        sender.navigationController?.pushViewController(vc, animated: true)
    }
    
}
