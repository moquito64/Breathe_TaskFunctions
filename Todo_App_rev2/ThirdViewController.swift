//
//  ThirdViewController.swift
//  Todo_App_rev2
//
//  Created by Sebastian Blanchette on 12/3/17.
//  Copyright © 2017 The Two Musketeers LLC. All rights reserved.
//
import UIKit
import Firebase
import GoogleSignIn
import FirebaseDatabase
class ThirdViewController: UIViewController, GIDSignInUIDelegate{
    
    let ref = Database.database().reference(withPath: "BreatheDatabase")
    let user = Auth.auth().currentUser
    var tableCount = 0
    var maxProgress = 1.0
    @IBOutlet weak var StatusTextField: UITextView!
   
    @IBOutlet weak var barprogress: UIProgressView!
   
   
    @objc func updateProgress() {
        
        print(self.barprogress.progress)
        self.barprogress.progress = Float(Double(self.tableCount) * 0.1)
        if (self.barprogress.progress <= Float(maxProgress)){
            self.perform(#selector(updateProgress), with: nil, afterDelay: 0.2)
        }
      
    }
    override func viewDidLoad() {
    super.viewDidLoad()
        ref.queryOrdered(byChild: "completed").observe(.value, with: { snapshot in
            var newItems: [TaskItem] = []
            
            for item in snapshot.children {
                let taskItem = TaskItem(snapshot: item as! DataSnapshot)
                if(taskItem.addedByUser == self.user?.email){
                    newItems.append(taskItem)
                }
                self.tableCount = newItems.count
                
            }
            
        })
        
        
        
    self.perform(#selector(updateProgress), with: nil, afterDelay: 0.2)
    GIDSignIn.sharedInstance().uiDelegate = self
    
   
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}
    
    @IBAction func SignOut(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        self.performSegue(withIdentifier: "signOut", sender: self)
    }
    
}

