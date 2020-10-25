//
//  SignUpVC+AuthViewDelegate.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/21/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

extension SignUpVC: AuthViewDelegate{
    
    func svprogressStatus(_ status: Bool) {
        if status{
            SVProgressHUD.show()
        }else{
            SVProgressHUD.dismiss()
        }
    }
    
    func didCompleteRegistering(_ completed: Bool) {
        if completed{
            Router.toHome(self)
        }
    }
    
}
