//
//  OrdersItemsTableViewCell.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/6/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class OrdersItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var quantityValue: UILabel!
    @IBOutlet weak var priceValue: UILabel!
    
    func loadUI(item: OrderItem){
        containerView.setupShadow()
        containerView.layer.cornerRadius = 15
        logo.layer.cornerRadius = logo.frame.height/2
        quantityValue.text = "\(item.count ?? 1)"
    }
    
}
