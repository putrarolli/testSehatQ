//
//  favoritesVC.swift
//  SehatQTest
//
//  Created by putra rolli on 22/09/19.
//  Copyright © 2019 putra rolli. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireObjectMapper
import SDWebImage
import JGProgressHUD

class HomeVC: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var seacrhProduct: UISearchBar!
    let hud = JGProgressHUD(style: .dark)

    var category = [Category]()
    var productPromo = [ProductPromo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
        requestData()
        setUpNavBar()
    }
    
    func setUpNavBar() {
        seacrhProduct.delegate = self
        seacrhProduct.sizeToFit()
        seacrhProduct.searchBarStyle = .minimal
        seacrhProduct.placeholder = "Search by username"
        seacrhProduct.tintColor = UIColor.lightGray
        seacrhProduct.barTintColor = UIColor.lightGray
        navigationItem.titleView = seacrhProduct
        seacrhProduct.isTranslucent = true
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let searchVC = SearchVC()
        searchVC.productPromo = self.productPromo
        self.present(searchVC, animated: true, completion: nil)
    }
    
    private func registerCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = layout
        
        let nib = UINib(nibName: "KategoriCollectionCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "kategoriCollectionCell")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.isPagingEnabled = false
    }
    
    func requestData() {
        self.hud.textLabel.text = "Loading"
        self.hud.show(in: self.view)
        let URL = "https://private-4639ce-ecommerce56.apiary-mock.com/home"
        Alamofire.request(URL).responseArray { (response: DataResponse<[ProdukModel]>) in
            if ((response.error) != nil) {
                
            }else {
                self.category = (response.result.value?[0].data?.category)!
                self.productPromo = (response.result.value?[0].data?.productPromo)!
                self.collectionView.reloadData()
            }
            self.hud.dismiss(afterDelay: 2.0)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
            
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.category.count
    }
            
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kategoriCollectionCell", for: indexPath) as! KategoriCollectionCell
        
        let image = self.category[indexPath.item].imageUrl
        cell.kategoriText.text = self.category[indexPath.item].name
        cell.kategoriImage.sd_setImage(with: URL(string: image!), placeholderImage: UIImage(named: "sehatq"))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 100.0)
    }
}


