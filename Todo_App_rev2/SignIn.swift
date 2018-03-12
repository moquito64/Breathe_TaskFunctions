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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        alreadyIN()
       
    }
    
    func alreadyIN(){
        if(GIDSignIn.sharedInstance().hasAuthInKeychain()){
            self.performSegue(withIdentifier: "LoginWorks", sender: self)
            
        }
        
    }
    
    @IBAction func LoginDidTouch(_ sender: GIDSignInButton) {
        
        GIDSignIn.sharedInstance().signInSilently()
        alreadyIN()
    
       
        
        
    }
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



 
