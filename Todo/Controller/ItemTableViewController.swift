//
//  ItemTableViewController.swift
//  Todo
//
//  Created by Ajay Vandra on 1/28/20.
//  Copyright © 2020 Ajay Vandra. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {
    var category:String = ""
    var arr = [Item]()
    var filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("item.plist")
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        if category == arr[indexPath.row].category
        {
            cell.textLabel?.text = arr[indexPath.row].itemName
            cell.accessoryType = arr[indexPath.row].done ? .checkmark : .none
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        arr[indexPath.row].done = !arr[indexPath.row].done
        
        saveData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    @IBAction func addItemBtn(_ sender: UIBarButtonItem) {
        var textField = UITextField()
            let alert = UIAlertController(title: "Add Item", message: "Ad", preferredStyle: .alert)
            let action = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
                let newItem = Item()
                newItem.itemName = textField.text!
                newItem.category = self.category
                self.arr.append(newItem)
                self.saveData()
                self.tableView.reloadData()
            }
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Item Name"
                textField = alertTextField
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    func loadData(){
        if let data = try? Data(contentsOf: filePath!){
            do{
                let decoder = PropertyListDecoder()
                arr = try decoder.decode([Item].self, from: data)
                
            }catch{
                print("Error")
            }
        }
    }
    func saveData(){
        let encoder = PropertyListEncoder()
        do{
            let enData = try? encoder.encode(arr)
            try enData?.write(to: filePath!)
        }
        catch{
            print("encoder error")
        }
        self.tableView.reloadData()
    }
}
