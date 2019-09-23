//
//  ProductModelRealm.swift
//  SehatQTest
//
//  Created by putra rolli on 23/09/19.
//  Copyright © 2019 putra rolli. All rights reserved.
//

import Foundation
import RealmSwift

class ProductModelRealm : Object {
    
    @objc dynamic var id = ""
    @objc dynamic var imageUrl = ""
    @objc dynamic var title = ""
    
}
