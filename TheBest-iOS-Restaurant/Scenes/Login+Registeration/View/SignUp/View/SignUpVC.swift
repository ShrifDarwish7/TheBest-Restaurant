//
//  SignUpVC.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/3/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import Closures

class SignUpVC: UIViewController , UIGestureRecognizerDelegate{

    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet var customTFs: [UITextField]!
    @IBOutlet var customViews: [UIView]!
    @IBOutlet weak var sendRequest: UIButton!
    @IBOutlet weak var chooseCollection: UICollectionView!
    @IBOutlet weak var agreeCheck: UIImageView!
    @IBOutlet weak var payTypeChooseCollection: UICollectionView!
    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var shopIconView: UIView!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var nameAr: UITextField!
    @IBOutlet weak var nameEn: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var add: UITextField!
    @IBOutlet weak var addEn: UITextField!
    @IBOutlet weak var descAr: UITextField!
    @IBOutlet weak var descEn: UITextField!
    @IBOutlet weak var deliverPrice: UITextField!
    @IBOutlet weak var ownerName: UITextField!
    @IBOutlet weak var placePhone: UITextField!
    @IBOutlet weak var placeEmial: UITextField!
    @IBOutlet weak var orderLimit: UITextField!
    
    
    var options = [Option]()
    var payOptions = [Option]()
    var categories: [MainCategory]?
    var authPresenter: AuthPresenter?
    
    var selectedImagere: UIImage?
    var selectedOwnerImage: UIImage?
    var selectedImageCert: UIImage?
    var selectedSignatureImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authPresenter = AuthPresenter(authViewDelegate: self)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        options.append(Option(id: "", title: "Taxi", selected: false))
        options.append(Option(id: "", title: "Restaurant", selected: false))
        options.append(Option(id: "", title: "Car rent", selected: false))
        options.append(Option(id: "", title: "Markets", selected: false))
        options.append(Option(id: "", title: "Special cars  ", selected: false))
        options.append(Option(id: "", title: "Furniture cars", selected: false))
        
        payOptions.append(Option(id: "", title: "Monthly", selected: false))
        payOptions.append(Option(id: "", title: "Annual", selected: false))
        payOptions.append(Option(id: "", title: "Monthly Annual", selected: false))
        
        loadUI()
        loadActions()
        
        let nib = UINib(nibName: "ChooseCollectionViewCell", bundle: nil)
        chooseCollection.register(nib, forCellWithReuseIdentifier: "ChooseCollectionViewCell")
        payTypeChooseCollection.register(nib, forCellWithReuseIdentifier: "ChooseCollectionViewCell")
        
        chooseCollection.numberOfItemsInSection { (_) -> Int in
            return self.options.count
        }.cellForItemAt { (index) -> UICollectionViewCell in
            
            let cell = self.chooseCollection.dequeueReusableCell(withReuseIdentifier: "ChooseCollectionViewCell", for: index) as! ChooseCollectionViewCell
            cell.loadFrom(option: self.options[index.row])
            return cell
            
        }.didSelectItemAt { (index) in
            
            self.options[index.row].selected = !self.options[index.row].selected!
            self.chooseCollection.reloadData()
            
        }.sizeForItemAt { (index) -> CGSize in
            return CGSize(width: self.chooseCollection.frame.width/2 - 10, height: 35)
        }
        
        payTypeChooseCollection.numberOfItemsInSection { (_) -> Int in
            return self.payOptions.count
        }.cellForItemAt { (index) -> UICollectionViewCell in
            
            let cell = self.payTypeChooseCollection.dequeueReusableCell(withReuseIdentifier: "ChooseCollectionViewCell", for: index) as! ChooseCollectionViewCell
            cell.loadFrom(option: self.payOptions[index.row])
            return cell
            
        }.didSelectItemAt { (index) in
            
            self.payOptions[index.row].selected = !self.payOptions[index.row].selected!
            self.payTypeChooseCollection.reloadData()
            
        }.sizeForItemAt { (index) -> CGSize in
            return CGSize(width: self.payTypeChooseCollection.frame.width/3+10, height: 50)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print(SharedData.selectedRegisteredCategoriesNames)
        print(SharedData.selectedRegisteredCityID ?? 0)
        print(SharedData.selectedRegisteredDistrictID ?? 0)
    }
    
    func loadUI(){
        shopIconView.layer.cornerRadius = shopIconView.frame.height/2
        sendRequest.layer.cornerRadius = 15
        for tf in customTFs{
            tf.addBottomBorder()
        }
        for v in customViews{
            v.setupShadow()
            v.layer.cornerRadius = 15
        }
        
    }

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadActions(){
        
        shopImage.addTapGesture { (_) in
            
            let imagePicker = UIImagePickerController.init(source: .photoLibrary, allow: .image, showsCameraControls: true, didCancel: { (controller) in
                controller.dismiss(animated: true, completion: nil)
            }) { (result, controller) in
                controller.dismiss(animated: true, completion: nil)
                self.shopImage.image = result.originalImage
                self.selectedImagere = result.originalImage
            }
            self.present(imagePicker, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func uploadImages(_ sender: UIButton) {
        let imagePicker = UIImagePickerController.init(source: .photoLibrary, allow: .image, showsCameraControls: true, didCancel: { (controller) in
            controller.dismiss(animated: true, completion: nil)
        }) { (result, controller) in
            controller.dismiss(animated: true, completion: nil)
            sender.setImage(result.originalImage, for: .normal)
            switch sender.tag{
            case 0:
                self.selectedOwnerImage = result.originalImage
            case 1:
                self.selectedSignatureImage = result.originalImage
            case 2:
                self.selectedImageCert = result.originalImage
            default:
                break
            }
        }
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func agreeAction(_ sender: UIButton) {
        if sender.tag == 0{
            agreeCheck.image = UIImage(named: "checked")
            sender.tag = 1
        }else{
            agreeCheck.image = UIImage(named: "unchecked")
            sender.tag = 0
        }
    }
    
    @IBAction func sendRequestAction(_ sender: Any) {
        
        for tf in self.customTFs{
            if tf.text!.isEmpty{
                showAlert(title: "", message: "Please fill out all registeration info")
                return
            }
        }
        
        guard let _ = self.selectedImagere, let _ = self.selectedOwnerImage, let _ = self.selectedSignatureImage, let _ = self.selectedImageCert else {
            showAlert(title: "", message: "Please upload required images")
            return
        }
        
        guard let _ = SharedData.selectedRegisteredCityID, let _ = SharedData.selectedRegisteredDistrictID,
            !SharedData.selectedRegisteredCategoriesIDs.isEmpty else {
                showAlert(title: "", message: "Please choose your place categories, government and district")
                return
        }
        
        let registeredInfo = RestaurantsInfo(
            name: name.text!,
            email: email.text!,
            password: pass.text!,
            nameAr: nameAr.text!,
            nameEn: nameEn.text!,
            imagere: selectedImagere!,
            description: descAr.text!,
            descriptionEn: descEn.text!,
            address: add.text!,
            addressEn: addEn.text!,
            categoryId: "\(SharedData.selectedRegisteredCategoriesIDs.map({ return "\($0)" }))",
            deliveryPrice: deliverPrice.text!,
            lat: "\(SharedData.userLat ?? 0.0)", lng: "\(SharedData.userLng ?? 0.0)",
            typeId: "0",
            government: "\(SharedData.selectedRegisteredCityID ?? 0)", district: "\(SharedData.selectedRegisteredDistrictID ?? 0)",
            placeOwnerName: ownerName.text!,
            ownerImage: selectedOwnerImage!,
            imgCert: selectedImageCert!,
            placeEmail: placeEmial.text!,
            signatureImage: selectedSignatureImage!,
            placePhone: placePhone.text!,
            orderLimit: orderLimit.text!,
            branches: "",
            workingHours: "",
            timeFrame: "",
            responsibles: "",
            fcmToken: "")
        
        authPresenter?.registerWith(prms: registeredInfo)
        
    }
    
    @IBAction func toChoose(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            Router.toChooseCategory(self, .Categories(nil), cityID: nil)
        case 1:
            Router.toChooseCategory(self, .Cities(nil), cityID: nil)
        default:
            break
        }
    }
    
    
}

