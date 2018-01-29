//
//  SignIn.swift
//  Todo_App_rev2
//
//  Created by Sebastian Blanchette on 1/9/18.
//  Copyright © 2018 The Two Musketeers LLC. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SignIn: UIViewController, GIDSignInUIDelegate {
    
    
    
    /*
    FirebaseApp.configure()
    authUI?.delegate = self
    let authUI = FUIAuth.defaultAuthUI()
    
    let providers: [FUIAuthProvider] = [
        FUIGoogleAuth()
        ]
    self.authUI?.providers = providers
    
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return false
    }
    let authViewController = authUI!.authViewController()

     
     
     */
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



 
