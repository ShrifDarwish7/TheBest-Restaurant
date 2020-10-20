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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
