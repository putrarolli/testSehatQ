//
//  downloadsVC.swift
//  SehatQTest
//
//  Created by putra rolli on 22/09/19.
//  Copyright © 2019 putra rolli. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class HistoryVC: UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }
    
    private func registerTableView() {
        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "SearchTableViewCell")
        self.tableView.rowHeight = 100
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        let image = realm.objects(ProductModelRealm.self)[indexPath.row].imageUrl
        cell.titleCell.text = realm.objects(ProductModelRealm.self)[indexPath.row].title
        cell.imageCell.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "sehatq"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(ProductModelRealm.self).count
    }
    
}
