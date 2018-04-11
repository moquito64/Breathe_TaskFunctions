//
//  FirstViewController.swift
//  Todo_App_rev2
//
//  Created by Sebastian Blanchette on 9/26/17.
//  Copyright © 2017 The Two Musketeers LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GoogleSignIn

class TaskViewController: UITableViewController {
    
    var todoItems: [TaskItem] = []
    var currentUsers: [String] = []
    var listUser: [String] = []
    var curCount = 0.0
    let user = Auth.auth().currentUser
    let ref = Database.database().reference(withPath: "BreatheDatabase")
    let usersRef = Database.database().reference(withPath: "online")
    
    
    
    
    
    @IBOutlet weak var myTableView: UITableView!
   
    
    
   
    
    public override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            let taskItem = todoItems[indexPath.row]
            taskItem.ref?.removeValue()
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // 1
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        // 2
        let taskItem = todoItems[indexPath.row]
        // 3
        let toggledCompletion = !taskItem.completed
        // 4
        toggleCellCheckbox(cell, isCompleted: toggledCompletion)
        // 5
        taskItem.ref?.updateChildValues([
            "completed": toggledCompletion
            ])
    }
    func toggleCellCheckbox(_ cell: UITableViewCell, isCompleted: Bool) {
        if !isCompleted {
            cell.accessoryType = .none
            cell.textLabel?.textColor = UIColor.black
            cell.detailTextLabel?.textColor = UIColor.black
        } else {
            cell.accessoryType = .checkmark
            cell.textLabel?.textColor = UIColor.gray
            cell.detailTextLabel?.textColor = UIColor.gray
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return todoItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_todo", for: indexPath)
        
        if indexPath.row < todoItems.count
        {
            let item = todoItems[indexPath.row]
            cell.textLabel?.text = item.name
            
            let accessory: UITableViewCellAccessoryType = item.completed ? .checkmark : .none
            cell.accessoryType = accessory
        }
        
        return cell
    }
    
    
    
    @objc func didTapAddItemButton(_ sender: UIBarButtonItem)
    {
        // Create an alert
        let alert = UIAlertController(title: "New Task Item",
                                      message: "Add a Task",
                                      preferredStyle: .alert)
        
        
        // Add a "cancel" button to the alert. This one doesn't need a handler
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        // Add a "OK" button to the alert. The handler calls addNewToDoItem()
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { _ in
                                        // 1
                                        guard let textField = alert.textFields?.first,
                                            let text = textField.text else { return }
                                        
                                        // 2
                                        let taskItem = TaskItem(name: text,
                                                                addedByUser: (self.user?.email)!,
                                                                      completed: false)
                                        // 3
                                        let taskItemRef = self.ref.child(text.lowercased())
                                        
                                        // 4
                                        taskItemRef.setValue(taskItem.toAnyObject())
        }
        
        // Present the alert to the user
        alert.addTextField()
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
   
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Task List"
        let currentUserRef = self.usersRef.child((self.user?.uid)!)
        // 2
        currentUserRef.setValue(self.user?.email)
        // 3
        currentUserRef.onDisconnectRemoveValue()
        
      
        ref.queryOrdered(byChild: "completed").observe(.value, with: { snapshot in
            var newItems: [TaskItem] = []
            
            for item in snapshot.children {
                let taskItem = TaskItem(snapshot: item as! DataSnapshot)
                if(taskItem.addedByUser == self.user?.email){
                newItems.append(taskItem)
                }
                
            }
            
            self.todoItems = newItems
            self.tableView.reloadData()
        })
       
       // self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(TaskViewController.didTapAddItemButton(_:)))
        
        
        
       
        usersRef.observe(.childAdded, with: { snap in
            // 2
            guard let email = snap.value as? String else { return }
            self.currentUsers.append(email)
            
    
        })
        
        usersRef.observe(.childRemoved, with: { snap in
            guard let emailToFind = snap.value as? String else { return }
            for (index, email) in self.currentUsers.enumerated() {
                if email == emailToFind {
                    self.currentUsers.remove(at: index)
                    
                }
            }
        })
    
            
    

        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
