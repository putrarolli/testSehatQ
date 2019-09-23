//
//  ProducDetailVC.swift
//  SehatQTest
//
//  Created by putra rolli on 23/09/19.
//  Copyright © 2019 putra rolli. All rights reserved.
//

import UIKit

class ProducDetailVC: UIViewController {

    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDesc: UITextView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productLove: UIImageView!
    
    var productPromo = [ProductPromo]()
    var indexProduct = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productTitle.text = productPromo[indexProduct].title
        self.productDesc.text = productPromo[indexProduct].description
        self.productPrice.text = "\(productPromo[indexProduct].price ?? "")"
        self.productImage.sd_setImage(with: URL(string: productPromo[indexProduct].imageUrl!), placeholderImage: UIImage(named: "sehatq"))
        
        if (self.productPromo[indexProduct].loved == 1) {
            self.productLove.image = UIImage(named:"heart_pink")
        }else {
            self.productLove.image = UIImage(named:"heart_white")
        }
    }

    @IBAction func backButtonPressed(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buyButtonPressed(sender: AnyObject) {
        
    }
    
    @IBAction func sharedButtonPressed(sender: AnyObject) {
        let shareText = "Hello, world!"
        
        if let image = UIImage(named: "sehatq") {
            let vc = UIActivityViewController(activityItems: [shareText, image], applicationActivities: [])
            self.present(vc, animated: true)
        }
    }
}
