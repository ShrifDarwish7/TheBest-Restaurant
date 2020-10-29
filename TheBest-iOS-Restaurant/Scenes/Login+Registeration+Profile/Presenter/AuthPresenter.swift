//
//  AuthPresenter.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/17/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol AuthViewDelegate {
    func svprogressStatus(_ status: Bool)
    func didCompleteLogin(_ error: Bool)
    func didCompleteRegistering(_ completed: Bool)
    func didCompleteWithAllCategories(_ categories: [MainCategory]?)
    func didCompleteWithSubCategories(_ categories: [MainCategory]?)
    func didCompleteWithCities(_ cities: [City]?)
    func didCompletWithDistricts(_ districts: [District]?)
    func didCompleteUpdateProfile(_ completed: Bool)
}

extension AuthViewDelegate{
    func svprogressStatus(_ status: Bool){}
    func didCompleteLogin(_ error: Bool){}
    func didCompleteRegistering(_ completed: Bool){}
    func didCompleteWithAllCategories(_ categories: [MainCategory]?){}
    func didCompleteWithSubCategories(_ categories: [MainCategory]?){}
    func didCompleteWithCities(_ cities: [City]?){}
    func didCompletWithDistricts(_ districts: [District]?){}
    func didCompleteUpdateProfile(_ completed: Bool){}
}

class AuthPresenter{
    
    var authViewDelegate: AuthViewDelegate?
    
    init(authViewDelegate: AuthViewDelegate) {
        self.authViewDelegate = authViewDelegate
    }
    
    func loginWith(email: String, pass: String, fcm: String){
        self.authViewDelegate?.svprogressStatus(true)
        AuthServices.loginWith(email, pass, fcm) { (completed) in
            self.authViewDelegate?.svprogressStatus(false)
            if completed{
             //   self.decodeRestaurantInfo()
                self.authViewDelegate?.didCompleteLogin(false)
            }else{
                self.authViewDelegate?.didCompleteLogin(true)
            }
        }
    }
    
    func registerWith(prms: RestaurantsInfo){
        self.authViewDelegate?.svprogressStatus(true)
        AuthServices.registerWith(restaurantsInfo: prms) { (completed) in
            self.authViewDelegate?.svprogressStatus(false)
            if completed{
                //self.decodeRestaurantInfo()
                self.authViewDelegate?.didCompleteRegistering(true)
            }else{
                self.authViewDelegate?.didCompleteRegistering(false)
            }
        }
    }
    
    func getAllCategories(){
        self.authViewDelegate?.svprogressStatus(true)
        AuthServices.getMainCategories { (response) in
            self.authViewDelegate?.svprogressStatus(false)
            if let _ = response{
                self.authViewDelegate?.didCompleteWithAllCategories(response?.MainCategories)
            }else{
                self.authViewDelegate?.didCompleteWithAllCategories(nil)
            }
        }
    }
    
    func getSubCategories(id: Int){
        self.authViewDelegate?.svprogressStatus(true)
        AuthServices.getCategoriesBy(id: id) { (response) in
            self.authViewDelegate?.svprogressStatus(false)
            if let _ = response{
                self.authViewDelegate?.didCompleteWithSubCategories(response?.items)
            }else{
                self.authViewDelegate?.didCompleteWithSubCategories(nil)
            }
        }
    }
    
    func getCities(){
        self.authViewDelegate?.svprogressStatus(true)
        AuthServices.getAllCities { (response) in
            self.authViewDelegate?.svprogressStatus(false)
            if let _ = response{
                self.authViewDelegate?.didCompleteWithCities(response?.cities)
            }else{
                self.authViewDelegate?.didCompleteWithCities(nil)
            }
        }
    }
    
    func getDitrictsBy(id: Int){
        self.authViewDelegate?.svprogressStatus(true)
        AuthServices.getDistrictBy(id) { (response) in
            self.authViewDelegate?.svprogressStatus(false)
            if let _ = response{
                self.authViewDelegate?.didCompletWithDistricts(response?.districts)
            }else{
                self.authViewDelegate?.didCompletWithDistricts(nil)
            }
        }
    }
    
    func updateProfile(prms: RestaurantsInfo){
        self.authViewDelegate?.svprogressStatus(true)
        AuthServices.updateMyRestaurantWith(restaurantsInfo: prms) { (completed) in
            self.authViewDelegate?.svprogressStatus(false)
            if completed{
               // self.decodeRestaurantInfo()
                self.authViewDelegate?.didCompleteUpdateProfile(true)
            }else{
                self.authViewDelegate?.didCompleteUpdateProfile(false)
            }
        }
    }
    
//    func decodeRestaurantInfo(){
//
//        AuthServices.instance.myRestaurant.decodedBranches = try? JSONDecoder.init().decode([Branch].self, from: AuthServices.instance.myRestaurant.branches.replacingOccurrences(of: "\\", with: "").data(using: .utf8) ?? Data())
//        AuthServices.instance.myRestaurant.decodedWorkingHours = try? JSONDecoder.init().decode([WorkingHours].self, from: AuthServices.instance.myRestaurant.workingHours.replacingOccurrences(of: "\\", with: "").data(using: .utf8) ?? Data())
//        AuthServices.instance.myRestaurant.decodedResponsibles = try? JSONDecoder.init().decode([Responsible].self, from: AuthServices.instance.myRestaurant.responsibles.replacingOccurrences(of: "\\", with: "").data(using: .utf8) ?? Data())
//        print("branches123",AuthServices.instance.myRestaurant.decodedBranches)
//
//    }
    
}
