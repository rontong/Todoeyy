//
//  ViewController.swift
//  Todoeyy
//
//  Created by Ronald Tong on 26/7/18.
//  Copyright © 2018 StokeDesign. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Take Myra for a walk", "Go for a Swim", "Go to Trivia Night"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }

   //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
    
        return cell
        
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print("Selected Row at \(indexPath.row)")
        //print(itemArray[indexPath.row])
        
        toggleCheckmark(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func toggleCheckmark(indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        
        if selectedCell?.accessoryType == .checkmark {
            selectedCell?.accessoryType = .none
        } else {
            selectedCell?.accessoryType = .checkmark
        }
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var newItemText = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What happens if user clicks Add Item Button on UI Alert
            
            self.itemArray.append(newItemText.text!)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()

        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            newItemText = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

