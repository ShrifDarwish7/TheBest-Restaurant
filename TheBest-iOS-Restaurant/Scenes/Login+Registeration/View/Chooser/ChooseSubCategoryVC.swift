//
//  ChooseSubCategoryVC.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/21/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import SVProgressHUD

class ChooseSubCategoryVC: UIViewController {

    @IBOutlet weak var chooseSubCategory: UICollectionView!
    @IBOutlet weak var confirmBtn: UIButton!
    
    var receivedId: Int?
    var cats: [MainCategory]?
    var authPresenter: AuthPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        authPresenter = AuthPresenter(authViewDelegate: self)
        authPresenter?.getSubCategories(id: self.receivedId!)
        confirmBtn.layer.cornerRadius = 10
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: SignUpVC.self) {
                let vc = controller as! SignUpVC
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    
}

extension ChooseSubCategoryVC: AuthViewDelegate{
    func SVProgressStatus(_ status: Bool) {
        if status{
            SVProgressHUD.show()
        }else{
            SVProgressHUD.dismiss()
        }
    }
    
    func didCompleteWithSubCategories(_ categories: [MainCategory]?) {
        if let _ = categories{
            self.cats = categories
            self.loadCollectionFromNib()
        }
    }
}

extension ChooseSubCategoryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func loadCollectionFromNib(){
        let nib = UINib(nibName: "ChooseCollectionViewCell", bundle: nil)
        chooseSubCategory.register(nib, forCellWithReuseIdentifier: "ChooseCollectionViewCell")
        chooseSubCategory.delegate = self
        chooseSubCategory.dataSource = self
        chooseSubCategory.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cats!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.chooseSubCategory.dequeueReusableCell(withReuseIdentifier: "ChooseCollectionViewCell", for: indexPath) as! ChooseCollectionViewCell
        
        for subcat in self.cats!{
            let temp = SharedData.selectedRegisteredCategoriesIDs.filter({ return $0 == subcat.id })
            if !temp.isEmpty{
                for i in 0...self.cats!.count-1{
                    if temp.contains(self.cats![i].id){
                        self.cats![i].selected = true
                    }
                }
            }
        }
        
        cell.loadFrom(category: self.cats![indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.cats![indexPath.row].selected ?? false{
            let tempIDs = SharedData.selectedRegisteredCategoriesIDs.filter({return $0 == self.cats![indexPath.row].id})
            if !tempIDs.isEmpty{
                for i in tempIDs{
                    if let index = SharedData.selectedRegisteredCategoriesIDs.firstIndex(of: i) {
                        SharedData.selectedRegisteredCategoriesIDs.remove(at: index)
                        
                    }
                }
                
                let tempNames = SharedData.selectedRegisteredCategoriesNames.filter({return $0 == self.cats![indexPath.row].name})
                if !tempNames.isEmpty{
                    for i in tempNames{
                        if let index = SharedData.selectedRegisteredCategoriesNames.firstIndex(of: i) {
                            SharedData.selectedRegisteredCategoriesNames.remove(at: index)
                            
                        }
                    }
                }
            }
        }else{
            SharedData.selectedRegisteredCategoriesNames.append(self.cats![indexPath.row].name)
            SharedData.selectedRegisteredCategoriesIDs.append(self.cats![indexPath.row].id)
        }
        self.cats![indexPath.row].selected = !(self.cats![indexPath.row].selected ?? false)
        self.chooseSubCategory.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.chooseSubCategory.frame.width, height: 50)
    }
}

