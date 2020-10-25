//
//  ProductVC+UITableViewDelegate.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/25/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension ProductVC: UITableViewDelegate, UITableViewDataSource{
    
    func loadVariationTableFromNIB(){
        let nib = UINib(nibName: "VariationTableViewCell", bundle: nil)
        self.variationTableView.register(nib, forCellReuseIdentifier: "VariationTableViewCell")
        self.variationTableView.delegate = self
        self.variationTableView.dataSource = self
        self.variationTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // let variations = self.itemReceived?.variations?.filter({ return !$0.body.isEmpty })
        print(itemReceived?.variations!.count)
        return (itemReceived?.variations!.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      //  let variations = self.itemReceived?.variations?.filter({ return !$0.body.isEmpty })
        let variations = self.itemReceived?.variations
        let cell = tableView.dequeueReusableCell(withIdentifier: "VariationTableViewCell", for: indexPath) as! VariationTableViewCell
        cell.loadUI()
        cell.variationName.text = variations![indexPath.row].titleEn
        
        let bodyNib = UINib(nibName: "VariationBodyTableViewCell", bundle: nil)
        cell.variationBodyTableView.register(bodyNib, forCellReuseIdentifier: "VariationBodyTableViewCell")
        cell.variationBodyTableView.delegate = self
        cell.variationBodyTableView.dataSource = self
        
        cell.variationBodyTableView.numberOfRows { (_) -> Int in
            return variations![indexPath.row].body.count
        }.cellForRow { (bodyIndex) -> UITableViewCell in
            
            let cell = cell.variationBodyTableView.dequeueReusableCell(withIdentifier: "VariationBodyTableViewCell", for: bodyIndex) as! VariationBodyTableViewCell
            cell.name.text = variations![indexPath.row].body[bodyIndex.row].nameEn
            print("mmnnnbody",variations![indexPath.row].body[bodyIndex.row].nameEn)
            cell.price.text = variations![indexPath.row].body[bodyIndex.row].price
            return cell
            
        }.heightForRowAt { (_) -> CGFloat in
            return 30
        }
        cell.variationBodyTBHeightCnst.constant = CGFloat(30 * variations![indexPath.row].body.count)
        cell.variationBodyTableView.reloadData()
        //self.viewWillLayoutSubviews()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (CGFloat((self.itemReceived?.variations?[indexPath.row].body.count)! * 30 + 70))
    }
    
}
