//
//  MarkerView.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 21/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

@IBDesignable
class MarkerView: UIView {

    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var infoView: ViewCorners!
    @IBOutlet weak var arrowDownIcon: UIImageView!
    
    let nibName = "MarkerView"
    var contentView: UIView?
    var orderOpened: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        NotificationCenter.default.addObserver(self, selector: #selector(self.openOrder), name: NSNotification.Name("OpenOrder"), object: nil)
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func loadOrderInfo(order: Order){
        self.orderId.text = "#\(order.id ?? 0)"
        self.clientName.text = "Client name : ".localized + (order.username ?? "")
        self.total.text = "Total : ".localized + (order.total ?? "") + " " + "KWD"
    }
    

    
    @objc func openOrder(){
        if self.orderOpened{
            self.orderOpened = false
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [], animations: {
                self.infoView.transform = CGAffineTransform(scaleX: 0, y: 0)
                self.arrowDownIcon.isHidden = true
                self.layoutIfNeeded()
            }) { (_) in
                
            }
        }else{
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [], animations: {
                self.infoView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.layoutIfNeeded()
            }) { (_) in
                self.orderOpened = true
                self.arrowDownIcon.isHidden = false
            }
        }
    }
    
    
}
