//
//  DrawerVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/22/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class DrawerVC: UIViewController {

    @IBOutlet weak var blockView: UIView!
    @IBOutlet weak var drawerView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var logout: UIStackView!
    @IBOutlet weak var lastOrders: UIStackView!
    @IBOutlet weak var home: UIStackView!
    @IBOutlet weak var howToUse: UIStackView!
    @IBOutlet weak var share: UIStackView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var balance: UIStackView!
    @IBOutlet weak var aboutUs: UIStackView!
    @IBOutlet weak var categories: UIStackView!
    @IBOutlet weak var reports: UIStackView!
    @IBOutlet weak var myRstaurant: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showBlockView), name: NSNotification.Name("opened"), object: nil)
        
        blockView.addTapGesture { (_) in
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
            self.blockView.alpha = 0
            
        }
        
        drawerView.setupShadow()
        
        backBtn.onTap {
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
            self.blockView.alpha = 0
            
        }
        
        logout.addTapGesture { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
            Router.toLoginVC(self)
            AuthServices.instance.isLogged = false
        }
        
        categories.addTapGesture { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
            Router.toCategories(self)
        }
        
        lastOrders.addTapGesture { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
            Router.toOrders(self)
        }
        
        reports.addTapGesture { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
            Router.toReports(self)
        }
        
        myRstaurant.addTapGesture { (_) in
            Router.toMyRestaurant(self)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        username.text = AuthServices.instance.myRestaurant.name
        profileImage.sd_setImage(with: URL(string: AuthServices.instance.myRestaurant.image ?? ""))
    }
 
    
    @objc func showBlockView(){
        UIView.animate(withDuration: 0.2, delay: 0.2, options: [], animations: {
             self.blockView.alpha = 0.5
        }) { (_) in
            
        }
    }

}
