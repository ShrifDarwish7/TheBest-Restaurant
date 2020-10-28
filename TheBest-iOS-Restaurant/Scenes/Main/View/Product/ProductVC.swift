//
//  ProductVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/27/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import SVProgressHUD

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
    @IBOutlet weak var actionBtn: UIButton!
    @IBOutlet weak var blockView: UIView!
    @IBOutlet weak var addVariationContainer: UIView!
    @IBOutlet weak var addBtn: UIView!
    @IBOutlet weak var addVariationViewPosition: NSLayoutConstraint!
    @IBOutlet weak var addVariationBtn: UIButton!
    @IBOutlet weak var addedVariationBodyTableView: UITableView!
    @IBOutlet weak var addedVariationNameEnTF: UITextField!
    @IBOutlet weak var addedVariationNameArTF: UITextField!
    @IBOutlet weak var addedBodyEn: UITextField!
    @IBOutlet weak var addedBodyAr: UITextField!
    @IBOutlet weak var addBodyPrice: UITextField!
    @IBOutlet weak var editNameTFAr: UITextField!
    @IBOutlet weak var editDescAr: UITextField!
    @IBOutlet weak var menuPickerTF: UITextField!
    @IBOutlet weak var addAdditionalView: UIView!
    @IBOutlet weak var additionalCollectionView: UICollectionView!
    @IBOutlet weak var addAdditionalBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addAdditionalViewPositionCnst: NSLayoutConstraint!
    @IBOutlet weak var productNameAr: UILabel!
    @IBOutlet weak var productDescAr: UILabel!
    @IBOutlet weak var previewStack: UIStackView!
    @IBOutlet weak var editStack: UIStackView!
    
    var itemReceived: RestaurantMenuItem?
    var vendorName: String?
    var vendorImage: String?
    var selectedVariationIndex: Int?
    var selectedVariationPrice: Int?
    var viewState: VCState?
    var selectedImage: UIImage?
    var addedVariationsBody = [BodyItem]()
    var addedVariations = [Variation]()
    let menuPicker = UIPickerView()
    var menus: [MyMenu]?
    var selectedMenuID: Int?
    var mainPresenter: MainPresenter?
    var additionalItems: [AdditionalItem]?
    var selectedAdditionalItems = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainPresenter = MainPresenter(mainViewDelegate: self)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
                
        backBtn.onTap {
            self.navigationController?.popViewController(animated: true)
        }
        for tf in customTFs{
            tf.addBottomBorder()
        }
        addBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addVariationActon)))
        actionBtn.layer.cornerRadius = 10
        addVariationContainer.setupShadow()
        addVariationContainer.layer.cornerRadius = 15
        addAdditionalView.setupShadow()
        addAdditionalView.layer.cornerRadius = 15
        addVariationViewPosition.constant = self.view.frame.height
        addAdditionalViewPositionCnst.constant = self.view.frame.height
        addBtn.layer.cornerRadius = 15
        addAdditionalBtn.layer.cornerRadius = 15
        
        switch viewState {
        case .preview:
            editStack.isHidden = true
            editImageBtn.isHidden = true
            actionBtn.isHidden = true
            addVariationBtn.isHidden = true
        case .edit,.add:
            actionBtn.isHidden = false
            previewStack.isHidden = true
            variationTableView.isHidden = true
            mainPresenter?.getMenus()
        default:
            break
        }
        
        switch viewState {
        case .add:
            actionBtn.setTitle("Add Product", for: .normal)
        case .edit:
            actionBtn.setTitle("Update Product", for: .normal)
        default:
            break
        }
        
        if let _ = itemReceived{
            productImageVIew.sd_setImage(with: URL(string: itemReceived?.hasImage ?? ""))
            productName.text = itemReceived?.nameEn
            productDesc.text = itemReceived?.descriptionEn
            productNameAr.text = itemReceived?.name
            productDescAr.text = itemReceived?.descriptionAr
            productPrice.text = "\(itemReceived?.price ?? "") KWD"
            switch viewState {
            case .edit:
                productImageVIew.sd_setImage(with: URL(string: itemReceived?.hasImage ?? ""))
                editNameTF.text = itemReceived?.nameEn
                editDesc.text = itemReceived?.descriptionEn
                editNameTFAr.text = itemReceived?.name
                editDescAr.text = itemReceived?.descriptionAr
                editProductPrice.text = "\(itemReceived?.price ?? "") KWD"
                variationTableView.isHidden = false
                for v in itemReceived!.variations!{
                    addedVariations.append(v)
                }
                selectedMenuID = Int((itemReceived?.menuCategoryID)!)!
            default:
                break
            }
            loadVariationTableFromNIB()
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.variationTableHeight?.constant = self.variationTableView.contentSize.height + 10
        self.view.layoutIfNeeded()
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

    @IBAction func close(_ sender: Any) {
        self.dismissAddVariationView()
        self.dismissAddAdditionalView()
    }
    
    @IBAction func showAddView(_ sender: Any) {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Add Variations", style: .default, handler: { (_) in
            self.blockView.isHidden = false
            self.addVariationViewPosition.constant = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, animations: {
                self.view.layoutIfNeeded()
            }) { (_) in
                
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Add Additional Options", style: .default, handler: { (_) in
            self.selectedAdditionalItems.removeAll()
            self.blockView.isHidden = false
            self.addAdditionalViewPositionCnst.constant = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, animations: {
                self.view.layoutIfNeeded()
            }) { (_) in
                self.mainPresenter?.getAdditionalItems()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func dismissAddVariationView(){
        self.blockView.isHidden = true
        self.addVariationViewPosition.constant = self.view.frame.height
        self.view.layoutIfNeeded()
    }
    
    func dismissAddAdditionalView(){
        self.blockView.isHidden = true
        self.addAdditionalViewPositionCnst.constant = self.view.frame.height
        self.view.layoutIfNeeded()
    }
    
    @IBAction func addVariationBodyActiob(_ sender: Any) {
        
        guard
            !self.addedVariationNameEnTF.text!.isEmpty,
            !self.addedVariationNameArTF.text!.isEmpty,
            !self.addedBodyEn.text!.isEmpty,
            !self.addedBodyAr.text!.isEmpty,
            !self.addBodyPrice.text!.isEmpty
            else {
                return
        }
        
        addedVariationsBody.append(BodyItem(nameAr: self.addedBodyAr.text!, nameEn: self.addedBodyEn.text!, price: self.addBodyPrice.text!))
        self.addedBodyAr.text! = ""
        self.addedBodyEn.text! = ""
        self.addBodyPrice.text! = ""
        self.addedBodyEn.becomeFirstResponder()
        self.loadAddedVariationTableFromNIB()
        
    }
    
    @objc func addVariationActon(){
        
        guard
            !self.addedVariationNameEnTF.text!.isEmpty,
            !self.addedVariationNameArTF.text!.isEmpty,
            !self.addedVariationsBody.isEmpty
            else {
                return
        }
        
        if addedVariations.count < 3{
            self.addedVariations.append(Variation(titleAr: self.addedVariationNameArTF.text!, titleEn: self.addedVariationNameEnTF.text!, body: self.addedVariationsBody))
            self.addedBodyAr.text! = ""
            self.addedBodyEn.text! = ""
            self.addBodyPrice.text! = ""
            self.addedVariationNameEnTF.text! = ""
            self.addedVariationNameArTF.text! = ""
            self.addedVariationsBody.removeAll()
            self.variationTableView.isHidden = false
            self.addedVariationBodyTableView.reloadData()
            self.loadVariationTableFromNIB()
            self.dismissAddVariationView()
        }else{
            showAlert(title: "", message: "You exceeded maximum number of variations")
        }
        
    }
    
    @IBAction func addAdditionalAction(_ sender: Any) {
        guard !selectedAdditionalItems.isEmpty else{
            showAlert(title: "", message: "Choose something")
            return
        }
        self.dismissAddAdditionalView()
        print("hereSelectedAdditionalItems",selectedAdditionalItems)
    }
    
    
    @IBAction func takeTheAction(_ sender: Any) {
        
        guard !editNameTFAr.text!.isEmpty, !editNameTF.text!.isEmpty, !editProductPrice.text!.isEmpty, !editDescAr.text!.isEmpty, !editDesc.text!.isEmpty else {
            showAlert(title: "", message: "Please fill out all required product attributes")
            return
        }
        guard (self.selectedMenuID != nil) else {
            showAlert(title: "", message: "Please pick product associated menu name")
            return
        }
        
        var productPrms = [
            "name_ar": editNameTFAr.text!,
            "name_en": editNameTF.text!,
            "price": editProductPrice.text!,
            "description_ar": editDescAr.text!,
            "description_en": editDesc.text!,
            "restaurant_id": "\(AuthServices.instance.myRestaurant.id)",
            "menu_category_id": "\(self.selectedMenuID ?? 0)",
            "cat_id": "1"
            ] as [String: String]
        
            if addedVariations.count > 0{
                productPrms["attribute_title_ar_one"] = addedVariations[0].titleAr
                productPrms["attribute_title_en_one"] = addedVariations[0].titleEn
                if let bodyEncoded = try? JSONEncoder.init().encode(addedVariations[0].body){
                    productPrms["attribute_body"] = String(bytes: bodyEncoded, encoding: .utf8)
                }
            }
            
            if addedVariations.count > 1{
                productPrms["attribute_title_ar_two"] = addedVariations[1].titleAr
                productPrms["attribute_title_en_two"] = addedVariations[1].titleEn
                if let bodyEncoded = try? JSONEncoder.init().encode(addedVariations[1].body){
                    productPrms["attribute_body_two"] = String(bytes: bodyEncoded, encoding: .utf8)
                }
            }
            
            if addedVariations.count > 2{
                productPrms["attribute_title_ar_three"] = addedVariations[2].titleAr
                productPrms["attribute_title_en_three"] = addedVariations[2].titleEn
                if let bodyEncoded = try? JSONEncoder.init().encode(addedVariations[2].body){
                    productPrms["attribute_body_three"] = String(bytes: bodyEncoded, encoding: .utf8)
                }
            }
            
            print("selectedAdditionalItems",selectedAdditionalItems)
            
            if !selectedAdditionalItems.isEmpty{
                for i in 0...selectedAdditionalItems.count-1{
                    productPrms["additional_id[\(i)]"] = "\(selectedAdditionalItems[i])"
                }
            }
            SVProgressHUD.show()
            print(addedVariations)
            print(productPrms)
        
        switch viewState {
        case .add:
            guard (self.selectedImage != nil) else {
                showAlert(title: "", message: "Please upload product image")
                return
            }
            mainPresenter?.addProduct(parameters: productPrms, image: selectedImage!)
        case .edit:
            guard (selectedImage != nil) else {
                mainPresenter?.updateProduct(id: (itemReceived?.id)!,parameters: productPrms, image: nil)
                return
            }
            mainPresenter?.updateProduct(id: (itemReceived?.id)!,parameters: productPrms, image: selectedImage!)
        default:
            break
        }
    }
    
    
}

enum VCState {
    case edit
    case preview
    case add
}
