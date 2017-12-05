//
//  SecondViewController.swift
//  Todo_App_rev2
//
//  Created by Sebastian Blanchette on 9/26/17.
//  Copyright © 2017 The Two Musketeers LLC. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var input: UITextField!
    
    @IBOutlet weak var DatePicker: UIDatePicker!
    
    
    @IBAction func addItem(_ sender: AnyObject) {
        if(input.text != "")
        {
            Todolist.append(input.text!)
            curCount = Todolist.count
            input.text = ""
            
        }
        
    }
    
    @IBAction func addTask(_ sender: UIButton) {
        self.view.endEditing(true)
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
