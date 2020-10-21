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
    var cats: [MainCategory]?
    var authPresenter: AuthPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authPresenter = AuthPresenter(authViewDelegate: self)
        authPresenter?.getAllCategories()
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
            self.cats = categories
            self.loadTableFromNib()
        }
    }
}

extension ChooseCategoryVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cats!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseCategoryTableViewCell", for: indexPath) as! ChooseCategoryTableViewCell
        cell.name.text = self.cats![indexPath.row].name
        cell.categoryImage.sd_setImage(with: URL(string: self.cats![indexPath.row].hasImage ?? ""))
        cell.categoryImage.layer.cornerRadius = cell.categoryImage.frame.height/2
        cell.container.setupShadow()
        cell.container.layer.cornerRadius = 15
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Router.toChooseSubCategory(self.cats![indexPath.row].id, self)
    }
    
    func loadTableFromNib(){
        let nib = UINib(nibName: "ChooseCategoryTableViewCell", bundle: nil)
        self.categoriesTable.register(nib, forCellReuseIdentifier: "ChooseCategoryTableViewCell")
        self.categoriesTable.delegate = self
        self.categoriesTable.dataSource = self
        self.categoriesTable.reloadData()
    }
    
}
