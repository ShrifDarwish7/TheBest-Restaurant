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
    var selectedSubCategories = [String]()
    var selectedIDs = [Int]()
    
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
                vc.receivedSubCategories = self.selectedSubCategories
                vc.receivedIDs = self.selectedIDs
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
        cell.loadFrom(category: self.cats![indexPath.row])
        if self.cats![indexPath.row].selected ?? false{
            self.selectedSubCategories.append(self.cats![indexPath.row].name)
            self.selectedIDs.append(self.cats![indexPath.row].id)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.cats![indexPath.row].selected = !(self.cats![indexPath.row].selected ?? false)
        self.chooseSubCategory.reloadData()
        self.selectedIDs.removeAll()
        self.selectedSubCategories.removeAll()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.chooseSubCategory.frame.width, height: 50)
    }
}
