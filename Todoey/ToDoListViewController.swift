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
    
   // let defaults = UserDefaults.standard
    
    // create a document directory path the "FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)" is an Array of URLS -->

    let dataFilePath = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadItems()
        

        
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
        self.saveData() // calling the encoder to save the toggle of done - Yes / No
        
        
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
            
            self.saveData() // calling the encoder to save the new item
            
          
            
          
          //  print(alert.textFields!.last!.text!) --> asked a question if I can use this instead of var textField
            // print(alert.alertTextField.text)
            
            
        }
        
        
        alert.addAction(action) // adding my defined action to alert controller
        
        
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func saveData () {
        
        // I write the new element to the Item.plist file I created
        // (1) need to create a encoder of PropertListEncoder()
        // (2) encode the itemArray to data and to have a catch loop
        // (3) write it to the URL
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray) // data is an array
            try data.write(to: dataFilePath!) // write can also throw an error
            
        } catch {
            print("Error in encoding itemArray\(error)")
        }
        
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            
            let decoder = PropertyListDecoder()
            
            do {
                itemArray = try decoder.decode([Items].self, from: data) // I need to tell the decoder that the data type to decode is array of type Items, and to get the data from the data object I created whic is linked to dataFilePath
            } catch {
                
                print("Error in getting the data\(error)")
            }
            
            
        }
        
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
    

//MARK-End of code

}

