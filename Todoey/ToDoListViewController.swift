//
//  ViewController.swift
//  Todoey
//
//  Created by Roey Vegerhof on 14/03/2018.
//  Copyright © 2018 Roey Vegerhof. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    
    var itemArray = [Items]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let item1 = Items()
        item1.title = "item1"
        itemArray.append(item1)
        
        let item2 = Items()
        item2.title = "item2"
        itemArray.append(item2)
        
        let item3 = Items()
        item3.title = "item3"
        itemArray.append(item3)
        
        if let items = defaults.array(forKey: "ToDoItemsArray") as? [Items] {
            itemArray = items
        }
        
        
    }
    
    
    //MARK - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // below - how we should disply each cell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Ternary operator
        // value - what I want to set
        // condition is the if check
        // value = condition ? value if ture : value if false
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//      --> instead of the below
//        if item.done {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
        
    }
    
    //MARK - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(itemArray[indexPath.row])
        
        
//        if itemArray[indexPath.row].done {
//
//            itemArray[indexPath.row].done = false
//
//        } else {
//
//            itemArray[indexPath.row].done = true
//        }
//          instead I can write the line below - equal the opposite (since it's a bool)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        tableView.deselectRow(at: indexPath, animated: true) // removes the gray selecting
        tableView.reloadData() // I recall the DataSource methos becuase I want to make the checkmark appear
        
        
        }
    
    
    //barbutton - add new item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField // textField is a global variable that grabs a reference to alertTextField
            
        }
        
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            print("success")
            
            let item = Items()
            item.title = textField.text!
            self.itemArray.append(item)
            self.tableView.reloadData()
            
           // self.itemArray.append(textField.text!)
           // self.defaults.set(self.itemArray, forKey: "ToDoItemsArray")
            
          
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

