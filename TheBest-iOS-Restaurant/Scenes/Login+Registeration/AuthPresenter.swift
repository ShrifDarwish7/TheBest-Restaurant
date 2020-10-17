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
    
}
