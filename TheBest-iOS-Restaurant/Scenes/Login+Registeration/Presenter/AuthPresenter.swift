//
//  AuthPresenter.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/17/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol AuthViewDelegate {
    func SVProgressStatus(_ status: Bool)
    func didCompleteLogin(_ error: Bool)
    func didCompleteWithAllCategories(_ categories: [MainCategory]?)
    func didCompleteWithSubCategories(_ categories: [MainCategory]?)
}

extension AuthViewDelegate{
    func SVProgressStatus(_ status: Bool){}
    func didCompleteLogin(_ error: Bool){}
    func didCompleteWithAllCategories(_ categories: [MainCategory]?){}
    func didCompleteWithSubCategories(_ categories: [MainCategory]?){}
}

class AuthPresenter{
    
    var authViewDelegate: AuthViewDelegate?
    
    init(authViewDelegate: AuthViewDelegate) {
        self.authViewDelegate = authViewDelegate
    }
    
    func loginWith(email: String, pass: String, fcm: String){
        self.authViewDelegate?.SVProgressStatus(true)
        AuthServices.loginWith(email, pass, fcm) { (completed) in
            self.authViewDelegate?.SVProgressStatus(false)
            if completed{
                self.authViewDelegate?.didCompleteLogin(false)
            }else{
                self.authViewDelegate?.didCompleteLogin(true)
            }
        }
    }
    
    func getAllCategories(){
        self.authViewDelegate?.SVProgressStatus(true)
        AuthServices.getMainCategories { (response) in
            self.authViewDelegate?.SVProgressStatus(false)
            if let _ = response{
                self.authViewDelegate?.didCompleteWithAllCategories(response?.MainCategories)
            }else{
                self.authViewDelegate?.didCompleteWithAllCategories(nil)
            }
        }
    }
    
    func getSubCategories(id: Int){
        self.authViewDelegate?.SVProgressStatus(true)
        AuthServices.getCategoriesBy(id: id) { (response) in
            self.authViewDelegate?.SVProgressStatus(false)
            if let _ = response{
                self.authViewDelegate?.didCompleteWithSubCategories(response?.items)
            }else{
                self.authViewDelegate?.didCompleteWithSubCategories(nil)
            }
        }
    }
    
}
