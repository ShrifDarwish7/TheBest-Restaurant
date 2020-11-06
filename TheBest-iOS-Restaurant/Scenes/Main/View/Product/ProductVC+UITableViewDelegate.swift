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
        self.viewDidLayoutSubviews()
    }
    
    func loadAddedVariationTableFromNIB(){
        let nib = UINib(nibName: "VariationBodyTableViewCell", bundle: nil)
        self.addedVariationBodyTableView.register(nib, forCellReuseIdentifier: "VariationBodyTableViewCell")
        self.addedVariationBodyTableView.delegate = self
        self.addedVariationBodyTableView.dataSource = self
        self.addedVariationBodyTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case variationTableView:
            switch viewState{
            case .add:
                return addedVariations.filter({return !$0.body.isEmpty}).count
            case .edit:
                return addedVariations.filter({return !$0.body.isEmpty}).count
            default:
                return (itemReceived?.variations!.count)!
            }
        case addedVariationBodyTableView:
            return addedVariationsBody.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case variationTableView:
            
            var variations: [Variation]?
            
            switch viewState{
            case .add:
                variations = self.addedVariations
            case .edit:
                variations = self.addedVariations.filter({return !$0.body.isEmpty})
            default:
                variations = self.itemReceived?.variations
            }
            
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
                cell.price.text = variations![indexPath.row].body[bodyIndex.row].price
                return cell
                
            }.heightForRowAt { (_) -> CGFloat in
                return 30
            }
            cell.variationBodyTBHeightCnst.constant = CGFloat(30 * variations![indexPath.row].body.count)
            cell.variationBodyTableView.reloadData()
            self.viewWillLayoutSubviews()
            return cell
            
        case addedVariationBodyTableView:
            
            let cell = addedVariationBodyTableView.dequeueReusableCell(withIdentifier: "VariationBodyTableViewCell", for: indexPath) as! VariationBodyTableViewCell
            cell.name.text = addedVariationsBody[indexPath.row].nameEn
            cell.price.text = addedVariationsBody[indexPath.row].price
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case variationTableView:
            var variations: [Variation]?
            switch viewState{
            case .add:
                variations = self.addedVariations
            case .edit:
                variations = self.addedVariations.filter({return !$0.body.isEmpty})
            default:
                variations = self.itemReceived?.variations
            }
            
            return (CGFloat((variations?[indexPath.row].body.count)! * 30 + 70))
        default:
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        switch tableView {
        case addedVariationBodyTableView:
            let trailingRemoveAction = UIContextualAction(style: .destructive, title: "Remove") { (_, _, _) in
                self.addedVariationsBody.remove(at: indexPath.row)
                self.addedVariationBodyTableView.reloadData()
            }
            return UISwipeActionsConfiguration(actions: [trailingRemoveAction])
        case variationTableView:
            switch viewState{
            case .add:
                let trailingRemoveAction = UIContextualAction(style: .destructive, title: "Remove") { (_, _, _) in
                    self.addedVariations.remove(at: indexPath.row)
                    self.variationTableView.reloadData()
                }
                return UISwipeActionsConfiguration(actions: [trailingRemoveAction])
            case .edit:
                if !(self.itemReceived?.variations!.isEmpty)!{
                    let trailingRemoveAction = UIContextualAction(style: .destructive, title: "Remove") { (_, _, _) in
                        self.addedVariations[indexPath.row] = Variation(titleAr: "", titleEn: "", body: [])
                        self.variationTableView.reloadData()
                    }
                    return UISwipeActionsConfiguration(actions: [trailingRemoveAction])
                }else{
                    return UISwipeActionsConfiguration()
                }
            default:
                return UISwipeActionsConfiguration()
            }
        default:
            return UISwipeActionsConfiguration()
        }
    }
    
}
