//
//  SearchVC.swift
//  SehatQTest
//
//  Created by putra rolli on 23/09/19.
//  Copyright © 2019 putra rolli. All rights reserved.
//

import UIKit

class SearchVC: UIViewController,UITableViewDataSource, UISearchBarDelegate  {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var productPromo = [ProductPromo]()
    
    var filteredData: [ProductPromo]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "SearchTableViewCell")
        self.tableView.rowHeight = 100
        tableView.dataSource = self
        searchBar.delegate = self
        filteredData = productPromo
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        let image = self.productPromo[indexPath.item].imageUrl
        cell.titleCell.text = filteredData[indexPath.row].title
        cell.imageCell.sd_setImage(with: URL(string: image!), placeholderImage: UIImage(named: "sehatq"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false {
            filteredData = productPromo.filter({ ($0.title?.contains(searchText))! })
        }else {
            filteredData = productPromo
        }
        
        tableView.reloadData()
    }

}
