//
//  SignUpVC+UITableViewDelegate.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/29/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension SignUpVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dataToBeAdded {
        case .Branches:
            return branches.count
        case .WorkingHours:
            return wokringHrs.count
        case .Responsibles:
            return responsibles.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        cell.selectionStyle = .none
        
        switch dataToBeAdded {
        case .Branches:
            cell.textLabel?.text = branches[indexPath.row].name + " " + branches[indexPath.row].phone + " " + branches[indexPath.row].address_en
            cell.detailTextLabel?.text = branches[indexPath.row].job
        case .WorkingHours:
            cell.textLabel?.text = wokringHrs[indexPath.row].name
            cell.detailTextLabel?.text = wokringHrs[indexPath.row].desc
        case .Responsibles:
            cell.textLabel?.text = responsibles[indexPath.row].name
            cell.detailTextLabel?.text = responsibles[indexPath.row].job
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        switch dataToBeAdded {
        case .Branches:
            let trailingRemoveAction = UIContextualAction(style: .destructive, title: "Remove") { (_, _, _) in
                self.branches.remove(at: indexPath.row)
                self.addedInfoTableView.reloadData()
            }
            return UISwipeActionsConfiguration(actions: [trailingRemoveAction])
        case .WorkingHours:
            let trailingRemoveAction = UIContextualAction(style: .destructive, title: "Remove") { (_, _, _) in
                self.wokringHrs.remove(at: indexPath.row)
                self.addedInfoTableView.reloadData()
            }
            return UISwipeActionsConfiguration(actions: [trailingRemoveAction])
        case .Responsibles:
            let trailingRemoveAction = UIContextualAction(style: .destructive, title: "Remove") { (_, _, _) in
                self.responsibles.remove(at: indexPath.row)
                self.addedInfoTableView.reloadData()
            }
            return UISwipeActionsConfiguration(actions: [trailingRemoveAction])
        default:
            return UISwipeActionsConfiguration()
        }
    }
    
}
