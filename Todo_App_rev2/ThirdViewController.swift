//
//  ThirdViewController.swift
//  Todo_App_rev2
//
//  Created by Sebastian Blanchette on 12/3/17.
//  Copyright © 2017 The Two Musketeers LLC. All rights reserved.
//
import UIKit
class ThirdViewController: UIViewController {
    
  
  
    @IBOutlet weak var StatusTextField: UITextView!
   
    @IBOutlet weak var barprogress: UIProgressView!
    
  

    override func viewDidLoad() {
    super.viewDidLoad()
    self.barprogress.progress = Float(curCount)
   
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}
    
    
}

