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

class LoginVC: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        setKeyboardDoneBtn()
    }
    
    @available(iOS, deprecated: 9.0)
    @IBAction func login(_ sender: Any) {
        self.facebooklogin()
    }
    
    @available(iOS, deprecated: 9.0)
    func facebooklogin() {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], handler: { (result, error) -> Void in

            print("\n\n result: \(String(describing: result))")
            print("\n\n Error: \(String(describing: error))")
            if (error == nil) {
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if(fbloginresult.isCancelled) {
                    //Show Cancel alert
                } else if(fbloginresult.grantedPermissions.contains("email")) {
                    self.returnUserData()
                    //fbLoginManager.logOut()
                }
            }
        })
    }
    
    
    func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            if ((error) != nil) {
                // Process error
                print("\n\n Error: \(String(describing: error))")
            } else {
                let resultDic = result as! NSDictionary
                print("\n\n  fetched user: \(String(describing: result))")
                if (resultDic.value(forKey:"name") != nil) {
                    let userName = resultDic.value(forKey:"name")! as! String as NSString?
                    print("\n User Name is: \(String(describing: userName))")
                }
                if (resultDic.value(forKey:"email") != nil) {
                    let userEmail = resultDic.value(forKey:"email")! as! String as NSString?
                    print("\n User Email is: \(String(describing: userEmail))")
                }
            }
        })
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
