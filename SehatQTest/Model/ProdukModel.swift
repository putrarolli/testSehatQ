//
//  ProdukModel.swift
//  SehatQTest
//
//  Created by putra rolli on 23/09/19.
//  Copyright © 2019 putra rolli. All rights reserved.
//

import Foundation
import ObjectMapper

class ProdukModel: Mappable {

    var data: Data?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
    
}
    
    
    class Data: Mappable {
        var category: [Category]?
        var productPromo: [ProductPromo]?

        required init?(map: Map) {
            
        }
        
        func mapping(map: Map) {
            category <- map["category"]
            productPromo <- map["productPromo"]
        }
    }
    
    class Category: Mappable {
        var imageUrl: String?
        var id: Int?
        var name: String?
        
        required init?(map: Map){
            
        }
        
        func mapping(map: Map) {
            imageUrl <- map["imageUrl"]
            id <- map["id"]
            name <- map["name"]
        }
    }
    
    class ProductPromo: Mappable {
        var imageUrl: String?
        var id: String?
        var title: String?
        var description: String?
        var price: String?
        var loved: Int?
        
        required init?(map: Map){
            
        }
        
        func mapping(map: Map) {
            imageUrl <- map["imageUrl"]
            id <- map["id"]
            title <- map["title"]
            description <- map["description"]
            price <- map["price"]
            loved <- map["loved"]
        }
    }
