//
//  BaseViewController.swift
//  SehatQTest
//
//  Created by putra rolli on 23/09/19.
//  Copyright © 2019 putra rolli. All rights reserved.
//

import Foundation
import UIKit
import FBSDKShareKit
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn

class BaseViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    var navBarDoneBtn: UINavigationBar? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarDoneBtn =  UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width,height: 44))
    }
    
    //MARK: GOOGLE
    func initGoogleSignIn() {
        GIDSignIn.sharedInstance().clientID = "265540153209-kf9n617pqjqai36cfepi06j9sre44ikl.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func doGoogleSignIn() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        //if any error stop and print the error
        if error != nil{
            print(error ?? "google error")
            return
        }
        print(user.profile.email)
    }
    
    //MARK: FACEBOOK
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
    
    //MARK: HIDEKEYBOARD
    func setShowHideKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    //MARK: KEYBOARD DONE BUTTON
    
    func setKeyboardDoneBtn() {
        let navItem = UINavigationItem()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        navItem.rightBarButtonItem = doneBtn
        
        navBarDoneBtn?.pushItem(navItem, animated: true)
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
    
}
