//
//  ItemTableViewController.swift
//  Collector
//
//  Created by Burak Firik on 12/7/17.
//  Copyright © 2017 Code Path. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {
  
  var items: [Item] = []
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  override func viewWillAppear(_ animated: Bool) {
    getItems()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return items.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    
    // Configure the cell...
    let item = items[indexPath.row]
    cell.textLabel?.text = item.title
    
    
    if let imageData = item.image  {
      if let img  = imageData as? NSData {
        let uiImg = img as! Data
        cell.imageView?.image = UIImage(data: uiImg)
      }
    }
    
    return cell
  }
  
  func getItems() {
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
      if let coreDataStuff = try? context.fetch(Item.fetchRequest()) as? [Item]  {
        if let coreDataItems = coreDataStuff {
          items = coreDataItems
          tableView.reloadData()
        }
      }
      
    }
    
  }
  
  
  
  
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }
  
  
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      print("Print")
     
      
      if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        let item = items[indexPath.row]
        context.delete(item)
        getItems()
      }
      
      
    }
  }
  
  
  
  
  
}
