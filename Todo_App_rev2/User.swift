//
//  User.swift
//  Todo_App_rev2
//
//  Created by Sebastian Blanchette on 3/11/18.
//  Copyright © 2018 The Two Musketeers LLC. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn
struct User {
    
    let uid: String
    let email: String
    
    init(authData: GIDGoogleUser) {
        uid = authData.userID
        email =
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
}
