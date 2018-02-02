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
class ThirdViewController: UIViewController, GIDSignInUIDelegate{
    
    var TODOItems = [ToDoItem]()
    var progressValue = 0.0
    var barValue = 0.0
  
    @IBOutlet weak var StatusTextField: UITextView!
   
    @IBOutlet weak var barprogress: UIProgressView!
   
    func getProgress(){
        let _otherVC = FirstViewController()
        TODOItems = _otherVC.todoItems
        
        barValue = _otherVC.curCount
    }
    @objc func updateProgress() {
        progressValue = progressValue + 0.01
        self.barprogress.progress = Float(progressValue)
        if progressValue != 1.0 {
            self.perform(#selector(updateProgress), with: nil, afterDelay: 0.2)
        }
    }
    override func viewDidLoad() {
    super.viewDidLoad()
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

