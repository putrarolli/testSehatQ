//
//  LoginVC.swift
//  SehatQTest
//
//  Created by putra rolli on 22/09/19.
//  Copyright © 2019 putra rolli. All rights reserved.
//

import Foundation
import UIKit
import FBSDKShareKit
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn

class LoginVC: BaseViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardDoneBtn()
        setShowHideKeyboard()
        initGoogleSignIn()
    }
    
    @IBAction func googleSignIn(sender: AnyObject) {
        doGoogleSignIn()
    }
    
    @available(iOS, deprecated: 9.0)
    @IBAction func login(_ sender: Any) {
        facebooklogin()
    }
    
    override func setKeyboardDoneBtn() {
        super.setKeyboardDoneBtn()
        nameTextField.inputAccessoryView = navBarDoneBtn
        passwordTextField.inputAccessoryView = navBarDoneBtn
    }

}
