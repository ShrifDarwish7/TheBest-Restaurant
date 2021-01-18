//
//  ProductVC+UICollectionViewDelegate.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/26/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension ProductVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func loadCollectionFromNib(){
        let nib = UINib(nibName: "ChooseCollectionViewCell", bundle: nil)
        additionalCollectionView.register(nib, forCellWithReuseIdentifier: "ChooseCollectionViewCell")
        additionalCollectionView.delegate = self
        additionalCollectionView.dataSource = self
        additionalCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.additionalItems!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.additionalCollectionView.dequeueReusableCell(withReuseIdentifier: "ChooseCollectionViewCell", for: indexPath) as! ChooseCollectionViewCell
        cell.loadFrom(additionalItem: additionalItems![indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.additionalItems![indexPath.row].selected = !(self.additionalItems![indexPath.row].selected ?? false)
        if self.additionalItems![indexPath.row].selected ?? false{
            if let index = self.selectedAdditionalItems.firstIndex(of: self.additionalItems![indexPath.row].id){
                self.selectedAdditionalItems.remove(at: index)
            }
        }else{
            self.selectedAdditionalItems.append(self.additionalItems![indexPath.row].id)
        }
        self.additionalCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.additionalCollectionView.frame.width, height: 50)
    }
}
