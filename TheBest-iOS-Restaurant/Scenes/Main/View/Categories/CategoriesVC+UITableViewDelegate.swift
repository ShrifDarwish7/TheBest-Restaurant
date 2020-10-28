//
//  CategoriesVC+UITableViewDelegate.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/20/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension CategoriesVC: UITableViewDelegate, UITableViewDataSource{
    
    func loadTableFromNib(){
        let nib = UINib(nibName: "ItemTableViewCell", bundle: nil)
        self.categoriesTableView.register(nib, forCellReuseIdentifier: "ItemTableViewCell")
        
        self.categoriesTableView.delegate = self
        self.categoriesTableView.dataSource = self
        self.categoriesTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menus!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        cell.name.text = self.menus?[indexPath.row].name
        cell.containerView.setupShadow()
        cell.containerView.layer.cornerRadius = 15
        return cell
        
    }
        
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let trailingRemoveAction = UIContextualAction(style: .normal, title: "Delete") { (_, _, _) in
            self.mainPresenter?.deleteMenu(id: self.menus![indexPath.row].id)
        }
        trailingRemoveAction.backgroundColor = UIColor.red
        return UISwipeActionsConfiguration(actions: [trailingRemoveAction])
       
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
        let leadingEditAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, _) in
            self.addCatBtn.tag = self.menus![indexPath.row].id
            self.presenteAddCatView()
        }
        leadingEditAction.backgroundColor = UIColor(named: "MainColor")
        return UISwipeActionsConfiguration(actions: [leadingEditAction])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Router.toChooseCategory(self, .MenuItems(nil), cityID: nil, menuID: self.menus?[indexPath.row].id)
    }
    
}
