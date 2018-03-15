//
//  ViewController.swift
//  Todoey
//
//  Created by Roey Vegerhof on 14/03/2018.
//  Copyright © 2018 Roey Vegerhof. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    
    var itemArray = ["first to do", "second to do", "third to do"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    
    //MARK - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(itemArray[indexPath.row])
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
           
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        
        tableView.deselectRow(at: indexPath, animated: true) // removes the gray selecting
        
        
        }
    
    
    //barbutton - add new item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField // textField is a global variable that grabs a reference to alertTextField
            
        }
        
        
        let action = UIAlertAction(title: "Add item", style: .default) { (actio) in
            print("success")
            
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
          
          //  print(alert.textFields!.last!.text!)
            // print(alert.alertTextField.text)
            
            
        }
        
        
        alert.addAction(action) // adding my defined action to alert controller
        
        
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
        //MARK-add delete when swiping
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action:UITableViewRowAction, indexPath:IndexPath) in
//           // print("delete at:\(indexPath)")
//
//
//          //  tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//
//        delete.backgroundColor = .red
//
//        let more = UITableViewRowAction(style: .default, title: "More") { (action:UITableViewRowAction, indexPath:IndexPath) in
//            print("more at:\(indexPath)")
//        }
//        more.backgroundColor = .orange
//
//        return [delete]
//    }
    



}

