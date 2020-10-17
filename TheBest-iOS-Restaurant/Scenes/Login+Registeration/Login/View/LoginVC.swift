//
//  LoginVC.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/2/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginVC: UIViewController {

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    var authPresenter: AuthPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authPresenter = AuthPresenter(authViewDelegate: self)
        
        loadUI()
        
    }
    
    func loadUI(){
        loginView.setupShadow()
        loginView.layer.cornerRadius = 15
        usernameView.layer.cornerRadius = usernameView.frame.height/2
        passView.layer.cornerRadius = passView.frame.height/2
        loginBtn.layer.cornerRadius = 15
        signupBtn.layer.cornerRadius = 15
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard !self.usernameTF.text!.isEmpty, !self.passTF.text!.isEmpty else {
            self.showAlert(title: "", message: "Please enter your email and password")
            return
        }
        self.authPresenter?.loginWith(email: usernameTF.text!, pass: passTF.text!, fcm: "")
    }
    
    @IBAction func signupAction(_ sender: Any) {
        Router.toSignUp(self)
    }
    
}

extension LoginVC: AuthViewDelegate{
    func SVProgressStatus(_ status: Bool) {
        if status{
            SVProgressHUD.show()
        }else{
            SVProgressHUD.dismiss()
        }
    }
    
    func didCompleteLogin(_ error: Bool) {
        if !error{
            Router.toHome(self)
        }
    }
    
    
}
