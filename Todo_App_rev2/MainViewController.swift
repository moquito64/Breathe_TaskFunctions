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
class MainViewController: UIViewController, GIDSignInUIDelegate{
    
    let ref = Database.database().reference(withPath: "BreatheDatabase")
    let user = Auth.auth().currentUser
    var tableCount = 0
    var maxProgress = 1.0
    @IBOutlet weak var mainViewTopBar: UINavigationBar!
    @IBOutlet weak var StatusTextField: UITextView!
    @IBOutlet weak var barprogress: UIProgressView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var NameOfUser: UILabel!
    
    let firstImageView = UIImageView(image: UIImage(named: "MaleState1.png"))
    let secondImageView = UIImageView(image: UIImage(named: "MaleState2.png"))
    let thirdImageView = UIImageView(image: UIImage(named: "MaleState3.png"))
    let forthImageView = UIImageView(image: UIImage(named: "MaleState4.png"))
    let fifthImageView = UIImageView(image: UIImage(named: "MaleState5.png"))
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if(self.tableCount  < 3){
            imageView.image = firstImageView.image
            StatusTextField.text = "Easy Breeze-y Cover Girl"
            
        }
        if(self.tableCount >= 3 && self.tableCount < 5)
        {
            imageView.image = secondImageView.image
            StatusTextField.text = "I feel like I am forgetting something"
        }
        if(self.tableCount >= 5 && self.tableCount < 7)
        {
            imageView.image = thirdImageView.image
            StatusTextField.text = "Looks like I might get busy"
        }
        if(self.tableCount >= 7 && self.tableCount < 9)
        {
            imageView.image = forthImageView.image
            StatusTextField.text = "Hmm...lots to do."
        }
        if(self.tableCount >= 9)
        {
            imageView.image = fifthImageView.image
            StatusTextField.text = "Ugg what a life...."
        }
       
    }
    
    
    @objc func updateProgress() {
        
        
        self.barprogress.progress = Float(Double(self.tableCount) * 0.1)
        if (self.barprogress.progress <= Float(maxProgress)){
            self.perform(#selector(updateProgress), with: nil, afterDelay: 0.2)
            
        }
        if(self.tableCount==0)
        {
            self.barprogress.progress=0
        }
      viewWillAppear(true)
    }
    

    override func viewDidLoad() {
    super.viewDidLoad()
        let transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 6.0)
        barprogress.transform = transform
        mainViewTopBar.topItem?.title = self.user?.displayName
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
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

