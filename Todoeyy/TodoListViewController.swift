//
//  ViewController.swift
//  Todoeyy
//
//  Created by Ronald Tong on 26/7/18.
//  Copyright © 2018 StokeDesign. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Take Myra for a walk", "Go for a Swim", "Go to Trivia Night"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}

