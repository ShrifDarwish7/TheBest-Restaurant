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
    @IBOutlet weak var blockView: UIView!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var addViewPosition: NSLayoutConstraint!
    @IBOutlet weak var addedInfoTableView: UITableView!
    @IBOutlet weak var addBtnView: UIView!
    @IBOutlet weak var branchesStack: UIStackView!
    @IBOutlet weak var workingHoursStack: UIStackView!
    @IBOutlet weak var responsiblesStack: UIStackView!
    @IBOutlet weak var addTitle: UILabel!
    @IBOutlet weak var branchName: UITextField!
    @IBOutlet weak var branchJob: UITextField!
    @IBOutlet weak var branchPhone: UITextField!
    @IBOutlet weak var branchAddEn: UITextField!
    @IBOutlet weak var branchAddAr: UITextField!
    @IBOutlet weak var workingHrsDesc: UITextField!
    @IBOutlet weak var workingHrsName: UITextField!
    @IBOutlet weak var workingHrsPrice: UITextField!
    @IBOutlet weak var resName: UITextField!
    @IBOutlet weak var resJob: UITextField!
    @IBOutlet weak var resPhone: UITextField!
    @IBOutlet weak var timeFrame: UITextField!
    @IBOutlet weak var pageTitle: UILabel!
    
    var options = [Option]()
    var payOptions = [Option]()
    var categories: [MainCategory]?
    var authPresenter: AuthPresenter?
    var dataToBeAdded: DataToBeAdded?
    var selectedImagere: UIImage?
    var selectedOwnerImage: UIImage?
    var selectedImageCert: UIImage?
    var selectedSignatureImage: UIImage?
    var branches = [Branch]()
    var wokringHrs = [WorkingHours]()
    var responsibles = [Responsible]()
    var pageType: PageType = .Register
    
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
    
    func showAddView(){
        addedInfoTableView.reloadData()
        switch dataToBeAdded {
        case .Branches:
            addTitle.text = "Branches"
            branchesStack.isHidden = false
        case .WorkingHours:
            addTitle.text = "Working Hours"
            workingHoursStack.isHidden = false
        case .Responsibles:
            addTitle.text = "Responsibles"
            responsiblesStack.isHidden = false
        default:
            break
        }
        self.blockView.isHidden = false
        self.addViewPosition.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            
        }
    }
    
    @IBAction func addToTableAction(_ sender: Any) {
        switch dataToBeAdded {
        case .Branches:
            guard !branchName.text!.isEmpty, !branchJob.text!.isEmpty, !branchAddAr.text!.isEmpty, !branchAddEn.text!.isEmpty,!branchPhone.text!.isEmpty else {
                showAlert(title: "", message: "Please enter all required branch information")
                return
            }
            branches.append(
                Branch(name: branchName.text!,
                       job: branchJob.text!,
                       phone: branchPhone.text!,
                       address_en: branchAddEn.text!,
                       address_ar: branchAddAr.text!))
            addedInfoTableView.reloadData()
            branchName.text! = ""
            branchJob.text! = ""
            branchAddAr.text! = ""
            branchAddEn.text! = ""
            branchPhone.text! = ""
        case .WorkingHours:
            guard !workingHrsName.text!.isEmpty, !workingHrsDesc.text!.isEmpty, !workingHrsPrice.text!.isEmpty else {
                showAlert(title: "", message: "Please enter all required working hours information")
                return
            }
            wokringHrs.append(WorkingHours(name: workingHrsName.text!, desc: workingHrsDesc.text!, price: workingHrsPrice.text!))
            addedInfoTableView.reloadData()
            workingHrsName.text! = ""
            workingHrsDesc.text! = ""
            workingHrsPrice.text! = ""
        case .Responsibles:
            guard !resName.text!.isEmpty, !resPhone.text!.isEmpty, !resJob.text!.isEmpty else {
                showAlert(title: "", message: "Please enter all required working hours information")
                return
            }
            responsibles.append(Responsible(name: resName.text!, job: resJob.text!, phone: resPhone.text!))
            addedInfoTableView.reloadData()
            resName.text! = ""
            resJob.text! = ""
            resPhone.text! = ""
        default:
            break
        }
    }
    
    
    func dismissAddView(){
        self.blockView.isHidden = true
        self.addViewPosition.constant = self.view.frame.height
        self.view.layoutIfNeeded()
        branchesStack.isHidden = true
        responsiblesStack.isHidden = true
        workingHoursStack.isHidden = true
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
        self.addViewPosition.constant = self.view.frame.height
        self.addBtnView.layer.cornerRadius = 10
        switch pageType {
        case .Register:
            pageTitle.text = "Register"
        case .Profile:
            sendRequest.setTitle("Update", for: .normal)
            pass.isHidden = true
            pageTitle.text = "My Restaurant"
            name.text = AuthServices.instance.myRestaurant.name
            nameAr.text = AuthServices.instance.myRestaurant.name
            nameEn.text = AuthServices.instance.myRestaurant.nameEn
            placeEmial.text = AuthServices.instance.myRestaurant.placeEmail
            add.text = AuthServices.instance.myRestaurant.address
            addEn.text = AuthServices.instance.myRestaurant.addressEn
            descAr.text = AuthServices.instance.myRestaurant.myresturantDescription
            descEn.text = AuthServices.instance.myRestaurant.descriptionEn
        //    deliverPrice.text = "\(AuthServices.instance.myRestaurant.deliveryPrice ?? 0)"
            deliverPrice.text = "0"
            ownerName.text = AuthServices.instance.myRestaurant.placeOwnerName
            placePhone.text = AuthServices.instance.myRestaurant.placePhone
            //orderLimit.text = "\(AuthServices.instance.myRestaurant.orderLimit)"
            orderLimit.text = "0"
            timeFrame.text = AuthServices.instance.myRestaurant.timeFrame
            shopImage.sd_setImage(with: URL(string: AuthServices.instance.myRestaurant.image ?? ""))
            branches =  (try? JSONDecoder.init().decode([Branch].self, from: AuthServices.instance.myRestaurant.branches.data(using: .utf8)!)) ?? []
            wokringHrs = (try? JSONDecoder.init().decode([WorkingHours].self, from: AuthServices.instance.myRestaurant.workingHours.data(using: .utf8)!)) ?? []
            responsibles = (try? JSONDecoder.init().decode([Responsible].self, from: AuthServices.instance.myRestaurant.responsibles.data(using: .utf8)!)) ?? []
            
        }
    }
    
    @IBAction func close(_ sender: Any) {
        dismissAddView()
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
    
    @IBAction func sendRequestAction(_ sender: UIButton) {
        
        let registeredInfo = RestaurantsInfo(
            name: name.text!,
            email: email.text!,
            password: pass.text!,
            nameAr: nameAr.text!,
            nameEn: nameEn.text!,
            imagere: selectedImagere,
            description: descAr.text!,
            descriptionEn: descEn.text!,
            address: add.text!,
            addressEn: addEn.text!,
            categoryId: "\(SharedData.selectedRegisteredCategoriesIDs.map({ return "\($0)" }))",
            deliveryPrice: deliverPrice.text!,
            lat: "\(SharedData.userLat ?? 0.0)", lng: "\(SharedData.userLng ?? 0.0)",
            typeId: "1",
            government: "\(SharedData.selectedRegisteredCityID ?? -1)", district: "\(SharedData.selectedRegisteredDistrictID ?? -1)",
            placeOwnerName: ownerName.text!,
            ownerImage: selectedOwnerImage,
            imgCert: selectedImageCert,
            placeEmail: placeEmial.text!,
            signatureImage: selectedSignatureImage,
            placePhone: placePhone.text!,
            orderLimit: orderLimit.text!,
            branches: String(bytes: try! JSONEncoder.init().encode(branches), encoding: .utf8) ?? "",
            workingHours: String(bytes: try! JSONEncoder.init().encode(wokringHrs), encoding: .utf8) ?? "",
            timeFrame: timeFrame.text!,
            responsibles: String(bytes: try! JSONEncoder.init().encode(responsibles), encoding: .utf8) ?? "",
            fcmToken: "")
        
        switch pageType {
        case .Register:
            
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
            
            authPresenter?.registerWith(prms: registeredInfo)
            
        case .Profile:
            authPresenter?.updateProfile(prms: registeredInfo)
        }
        
    }
    
    @IBAction func toChoose(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            Router.toChooseCategory(self, .Categories(nil), cityID: nil, menuID: nil)
        case 1:
            Router.toChooseCategory(self, .Cities(nil), cityID: nil, menuID: nil)
        case 2:
            dataToBeAdded = .Branches
            showAddView()
        case 3:
            dataToBeAdded = .WorkingHours
            showAddView()
        case 4:
            dataToBeAdded = .Responsibles
            showAddView()
        default:
            break
        }
    }
    
    
}

enum DataToBeAdded{
    case Branches
    case WorkingHours
    case Responsibles
}

enum PageType{
    case Register
    case Profile
}
