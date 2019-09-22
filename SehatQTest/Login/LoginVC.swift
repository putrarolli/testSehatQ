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
    var window: UIWindow?

    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardDoneBtn()
        setShowHideKeyboard()
        initGoogleSignIn()
    }
    
    @IBAction func googleSignIn(sender: AnyObject) {
        doGoogleSignIn()
    }
    
    @IBAction func loginBtnOnClick(sender: AnyObject) {
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = UITabBarController()
        window?.rootViewController = tabBarController
        
        let tabViewController1 = HomeVC()
        let tabViewController2 = HistoryVC()
        
        let controllers = [tabViewController1,tabViewController2]
        tabBarController.viewControllers = controllers
        window?.rootViewController = tabBarController
        tabViewController1.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(named: "pie_bar_icon"),
            tag: 1)
        tabViewController2.tabBarItem = UITabBarItem(
            title: "History",
            image:UIImage(named: "pizza_bar_icon") ,
            tag:2)
        window?.makeKeyAndVisible()
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
