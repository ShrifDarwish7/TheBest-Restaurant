//
//  ChooseCategoryVC.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/21/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

class ChooseCategoryVC: UIViewController {

    @IBOutlet weak var categoriesTable: UITableView!
    //var cats: [MainCategory]?
    var authPresenter: AuthPresenter?
    var chooserType: ChooserType?
    var receivedCityId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authPresenter = AuthPresenter(authViewDelegate: self)
        switch chooserType {
        case .Categories(_):
            authPresenter?.getAllCategories()
        case .Cities(_):
            authPresenter?.getCities()
        case .Districts(_):
            authPresenter?.getDitrictsBy(id: self.receivedCityId!)
        default:
            break
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ChooseCategoryVC: AuthViewDelegate{
    func SVProgressStatus(_ status: Bool) {
        if status{
            SVProgressHUD.show()
        }else{
            SVProgressHUD.dismiss()
        }
    }
    
    func didCompleteWithAllCategories(_ categories: [MainCategory]?) {
        if let _ = categories{
            self.chooserType = .Categories(categories!)
            self.loadTableFromNib()
        }
    }
    
    func didCompleteWithCities(_ cities: [City]?) {
        if let _ = cities{
            self.chooserType = .Cities(cities!)
            self.loadTableFromNib()
        }
    }
    
    func didCompletWithDistricts(_ districts: [District]?) {
        if let _ = districts{
            self.chooserType = .Districts(districts)
            self.loadTableFromNib()
        }
    }
}

extension ChooseCategoryVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.chooserType {
        case .Categories(let cats):
            return cats!.count
        case .Cities(let cities):
            return cities!.count
        case .Districts(let districts):
            return districts!.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseCategoryTableViewCell", for: indexPath) as! ChooseCategoryTableViewCell
        
        switch self.chooserType {
        case .Categories(let cats):
            cell.name.text = cats![indexPath.row].name
            cell.categoryImage.sd_setImage(with: URL(string: cats![indexPath.row].hasImage ?? ""))
        case .Cities(let cities):
            cell.name.text = cities![indexPath.row].name
            cell.imageContainer?.isHidden = true
        case .Districts(let districts):
            cell.name.text = districts![indexPath.row].name
            cell.imageContainer?.isHidden = true
            cell.arrowNext.isHidden = true
        default:
            return UITableViewCell()
        }
        
        cell.categoryImage.layer.cornerRadius = cell.categoryImage.frame.height/2
        cell.container.setupShadow()
        cell.container.layer.cornerRadius = 15
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.chooserType {
        case .Categories(let cats):
            Router.toChooseSubCategory(cats![indexPath.row].id, self)
        case .Cities(let cities):
            Router.toChooseCategory(self, .Districts(nil), cityID: cities![indexPath.row].id)
            SharedData.selectedRegisteredCityID = cities![indexPath.row].id
        case .Districts(let districts):
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: SignUpVC.self) {
                    //let vc = controller as! SignUpVC
                    SharedData.selectedRegisteredDistrictID = districts![indexPath.row].id
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
        default:
            break
        }
        
    }
    
    func loadTableFromNib(){
        let nib = UINib(nibName: "ChooseCategoryTableViewCell", bundle: nil)
        self.categoriesTable.register(nib, forCellReuseIdentifier: "ChooseCategoryTableViewCell")
        self.categoriesTable.delegate = self
        self.categoriesTable.dataSource = self
        self.categoriesTable.reloadData()
    }
    
}

enum ChooserType{
    case Categories(_ categories: [MainCategory]?)
    case Cities(_ cities: [City]?)
    case Districts(_ districts: [District]?)
}
