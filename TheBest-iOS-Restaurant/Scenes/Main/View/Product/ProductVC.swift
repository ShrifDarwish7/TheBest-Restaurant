//
//  ProductVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/27/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class ProductVC: UIViewController , UIGestureRecognizerDelegate{

    @IBOutlet weak var productImageVIew: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet weak var variationTitle: UILabel!
    @IBOutlet weak var variationViewHeight: NSLayoutConstraint!
    @IBOutlet weak var variationTableHeight: NSLayoutConstraint!
    @IBOutlet weak var variationTableView: UITableView!
    @IBOutlet weak var variationView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var editNameTF: UITextField!
    @IBOutlet weak var editDesc: UITextField!
    @IBOutlet var customTFs: [UITextField]!
    @IBOutlet weak var editProductImage: UIImageView!
    @IBOutlet weak var editImageBtn: UIButton!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var editProductPrice: UITextField!
    @IBOutlet weak var updateBtn: UIButton!
    
    var itemReceived: RestaurantMenuItem?
    var vendorName: String?
    var vendorImage: String?
    var selectedVariationIndex: Int?
    var selectedVariationPrice: Int?
    var viewState: VCState?
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
                
        backBtn.onTap {
            self.navigationController?.popViewController(animated: true)
        }
        for tf in customTFs{
            tf.addBottomBorder()
        }
        updateBtn.layer.cornerRadius = 10
        productImageVIew.sd_setImage(with: URL(string: itemReceived?.hasImage ?? ""))
        productName.text = itemReceived?.nameEn
        productDesc.text = itemReceived?.descriptionEn
        productPrice.text = "\(itemReceived?.price ?? "") KWD"
        
        switch viewState {
        case .preview:
            editNameTF.isHidden = true
            editDesc.isHidden = true
            editImageBtn.isHidden = true
            editProductPrice.isHidden = true
            updateBtn.isHidden = true
        case .edit:
            productName.isHidden = true
            productDesc.isHidden = true
            updateBtn.isHidden = false
            productPrice.isHidden = true
        default:
            break
        }
        
        loadVariationTableFromNIB()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.variationTableHeight?.constant = self.variationTableView.contentSize.height + 10
        self.view.layoutIfNeeded()
    }
    
    @IBAction func updateAction(_ sender: Any) {
    }
    
    
    @IBAction func editImage(_ sender: Any) {
        let imagePicker = UIImagePickerController.init(source: .photoLibrary, allow: .image, showsCameraControls: true, didCancel: { (controller) in
            controller.dismiss(animated: true, completion: nil)
        }) { (result, controller) in
            controller.dismiss(animated: true, completion: nil)
            self.productImageVIew.image = result.originalImage
            self.selectedImage = result.originalImage
        }
        self.present(imagePicker, animated: true, completion: nil)
    }

}

enum VCState {
    case edit
    case preview
}
