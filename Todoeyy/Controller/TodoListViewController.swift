//
//  ViewController.swift
//  Todoeyy
//
//  Created by Ronald Tong on 26/7/18.
//  Copyright © 2018 StokeDesign. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    // Locate the UI Application class, find the shared singleton object, locate it's delegate (App Delegate) and cast that as App Delegate object
    // Then find the persistentContainer and viewContext properties
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        print("*** Document Directory \(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))")

        loadItems()
        
    }

    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Ternary operator. value = condition ? valueIfTrue : valueIfFalse
        // If the item.checked is true, then set the cell.accessoryType to .checkmark. Otherwise set it to .none
        
        cell.accessoryType = item.checked ? .checkmark : .none
        
        return cell
        
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Toggle checked attribute 
        itemArray[indexPath.row].checked = !itemArray[indexPath.row].checked
        
        saveData()
        tableView.deselectRow(at: indexPath, animated: true)
   
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var newItemText = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What happens if user clicks Add Item Button on UI Alert
            
            let newItem = Item(context: self.context)
            newItem.title = newItemText.text!
            newItem.checked = false
            self.itemArray.append(newItem)
            
            self.saveData()

        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            newItemText = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveData() {
        
        do {
            try context.save()
        } catch {
            print("***Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    // LoadItems called with an argument will use NSFetchRequest<Item>
    // If LoadItems is called with no argument it will use the default value Item.fetchRequest()
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("***Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
}

//MARK: - Search Bar Methods

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        // For each item in the array, look for the item with title containing %@ searchBar.text. Modify the request with predicate and then sort.
        let searchRequest : NSFetchRequest<Item> = Item.fetchRequest()
        
        searchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        searchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: searchRequest)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
