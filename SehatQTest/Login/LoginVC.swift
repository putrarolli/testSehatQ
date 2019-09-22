//
//  LoginVC.swift
//  SehatQTest
//
//  Created by putra rolli on 22/09/19.
//  Copyright © 2019 putra rolli. All rights reserved.
//

import Foundation
import UIKit

class LoginVC: UIViewController {

@IBOutlet weak var nameTextField: UITextField!
@IBOutlet weak var passwordTextField: UITextField!

override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
    setKeyboardDoneBtn()
}

private func setKeyboardDoneBtn() {
    let navItem = UINavigationItem()
    let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done,
    target: self, action: #selector(self.doneClicked))
    navItem.rightBarButtonItem = doneBtn

    let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width,
    height: 44))
    navBar.pushItem(navItem, animated: true)

    nameTextField.inputAccessoryView = navBar
    passwordTextField.inputAccessoryView = navBar
}

@objc func doneClicked() {
    view.endEditing(true)
}

@objc func keyboardWillShow(sender: NSNotification) {
    self.view.frame.origin.y = -150
}

@objc func keyboardWillHide(sender: NSNotification) {
    self.view.frame.origin.y = 0
}

}
