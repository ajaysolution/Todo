//
//  TableViewController.swift
//  tableview
//
//  Created by Ajay Vandra on 1/28/20.
//  Copyright © 2020 Ajay Vandra. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("path.plist")
    var arr = [Datas]()
    var category:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewCell", for: indexPath)
        
        let item = arr[indexPath.row].name
        
        cell.textLabel?.text = item
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        category=arr[indexPath.row].name
        performSegue(withIdentifier: "show", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        let vc = segue.destination as! ItemTableViewController
        vc.category = category
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
    }
    func loadData(){
        if let data = try? Data(contentsOf: filePath!){
            do{
                let decoder = PropertyListDecoder()
                arr = try decoder.decode([Datas].self, from: data)
                
            }catch{
                print("Error")
            }
        }
    }
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Item", message: "Ad", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            let newItem = Datas()
            newItem.name = textField.text!
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
}
