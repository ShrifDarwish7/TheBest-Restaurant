//
//  CategoriesVC.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/20/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class CategoriesVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var drawerBtn: UIButton!
    @IBOutlet weak var drawerPosition: NSLayoutConstraint!
    @IBOutlet weak var blockView: UIView!
    @IBOutlet weak var addCatView: UIView!
    @IBOutlet weak var catName: UITextField!
    @IBOutlet weak var catFramView: UIView!
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var addCatBtn: UIButton!
    @IBOutlet weak var presentCatView: UIView!
    @IBOutlet weak var catViewCnst: NSLayoutConstraint!
    @IBOutlet weak var categoriesTableView: UITableView!
    @IBOutlet weak var cateName: UITextField!
    
    var menus: [MyMenu]?
    var mainPresenter: MainPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainPresenter = MainPresenter(mainViewDelegate: self)
        self.mainPresenter?.getMenus()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(closeDrawer), name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
        loadUI()

    }
    
    func loadUI(){
           
           drawerPosition.constant = self.view.frame.width
           upperView.setupShadow()
           upperView.layer.cornerRadius = upperView.frame.height/2
           
           drawerBtn.onTap {
               Drawer.open(self.drawerPosition, self)
           }
           
           backBtn.onTap {
               self.navigationController?.popViewController(animated: true)
           }
           
           addCatView.setupShadow()
           addCatView.layer.cornerRadius = 15
           catViewCnst.constant = self.view.frame.height
           
           catFramView.layer.cornerRadius = catFramView.frame.height/2
           
           addCatBtn.layer.cornerRadius = 10
           presentCatView.layer.cornerRadius = 10
           presentCatView.setupShadow()
           
           presentCatView.addTapGesture { (_) in
               self.presenteAddCatView()
           }
           
           blockView.addTapGesture { (_) in
               self.dismissCatView()
           }
           
           catName.addBottomBorder()
           
       }
       
       @objc func closeDrawer(){
           Drawer.close(drawerPosition, self)
       }
       
       func presenteAddCatView(){
           blockView.isHidden = false
           UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, animations: {
               self.catViewCnst.constant = 0
               self.view.layoutIfNeeded()
           }) { (_) in
               
           }
       }
       
       func dismissCatView(){
           self.blockView.isHidden = true
           self.catViewCnst.constant = self.view.frame.height
       }
    
    @IBAction func addMenuAction(_ sender: Any) {
        guard !self.cateName.text!.isEmpty else {
            showAlert(title: "", message: "Please enter menu name")
            return
        }
        self.mainPresenter?.addMenu(name: self.cateName.text!)
    }
    

}