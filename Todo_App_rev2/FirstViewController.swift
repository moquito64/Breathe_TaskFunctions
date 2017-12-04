//
//  FirstViewController.swift
//  Todo_App_rev2
//
//  Created by Sebastian Blanchette on 9/26/17.
//  Copyright © 2017 The Two Musketeers LLC. All rights reserved.
//

import UIKit
class FirstViewController: UIViewController,UITableViewDelegate{
   
    weak var StatusField: UITextView!{
        
        self.StatusField!.layer.borderWidth = 1
        self.StatusField!.layer.borderColor = UIColor.black.cgColor
        
        return self.StatusField
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view, typically from a nib.
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
