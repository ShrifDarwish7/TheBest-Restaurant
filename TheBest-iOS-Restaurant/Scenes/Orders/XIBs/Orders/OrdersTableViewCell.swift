//
//  OrdersTableViewCell.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/6/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var itemsView: UIView!
    @IBOutlet weak var itemsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var itemsTableViewHeight: NSLayoutConstraint!
    @IBOutlet var views: [UIView]!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var denyBtn: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var expandBtn: UIButton!
    
    func loadUI(){
        statusLbl.layer.cornerRadius = 10
        acceptBtn.layer.cornerRadius = 10
        denyBtn.layer.cornerRadius = 10
        denyBtn.layer.borderWidth = 1.5
        denyBtn.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.568627451, blue: 0.2117647059, alpha: 1)
        for v in views{
            v.setupShadow()
            v.layer.cornerRadius = 10
        }
    }
    
}
