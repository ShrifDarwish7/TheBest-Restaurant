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
        vc.modalPresentationStyle = .fullScreen
        sender.present(vc, animated: true, completion: nil)
    }
    
    static func toSignUp(_ sender: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        vc.modalPresentationStyle = .fullScreen
        sender.present(vc, animated: true, completion: nil)
    }
    
    static func toHome(_ sender: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        vc.modalPresentationStyle = .fullScreen
        sender.present(vc, animated: true, completion: nil)
    }
    
    static func toCategories(_ sender: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CategoriesVC") as! CategoriesVC
        vc.modalPresentationStyle = .fullScreen
        sender.present(vc, animated: true, completion: nil)
    }
    
    static func toOrders(_ sender: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OrdersVC") as! OrdersVC
        vc.modalPresentationStyle = .fullScreen
        sender.present(vc, animated: true, completion: nil)
    }
    
}
