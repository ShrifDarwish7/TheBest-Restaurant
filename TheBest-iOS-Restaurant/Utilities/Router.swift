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
        let vc = storyboard.instantiateViewController(withIdentifier: "CategoriesVC") as! CategoriesVC
        guard !(sender.navigationController?.topViewController?.isKind(of: CategoriesVC.self))! else { return }
        sender.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func toCategories(_ sender: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CategoriesVC") as! CategoriesVC
        guard !(sender.navigationController?.topViewController?.isKind(of: CategoriesVC.self))! else { return }
        sender.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func toOrders(_ sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OrdersVC") as! OrdersVC
        
        if let visibleVC = sender.navigationController?.visibleViewController as? OrdersVC,
            visibleVC.orders == .old{
            return
        }else{
            sender.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    static func toNewOrders(_ sender: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OrdersVC") as! OrdersVC
        vc.orders = .new
        if let visibleVC = sender.navigationController?.visibleViewController as? OrdersVC ,
            visibleVC.orders == .new{
            return
        }else{
            sender.navigationController?.pushViewController(vc, animated: true)
        }
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
        guard !(sender.navigationController?.topViewController?.isKind(of: ReportsVC.self))! else { return }
        sender.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func toProduct(_ sender: UIViewController,_ item: RestaurantMenuItem?, viewState: VCState){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
        vc.itemReceived = item
        vc.viewState = viewState
        guard !(sender.navigationController?.topViewController?.isKind(of: ProductVC.self))! else { return }
        sender.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func toMyRestaurant(_ sender: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        vc.pageType = .Profile
        guard !(sender.navigationController?.topViewController?.isKind(of: SignUpVC.self))! else { return }
        sender.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func toMap(_ sender: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        guard !(sender.navigationController?.topViewController?.isKind(of: MapVC.self))! else { return }
        sender.navigationController?.pushViewController(vc, animated: true)
    }
    
}
