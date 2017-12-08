//
//  MainTableViewController.swift
//  Collector
//
//  Created by Burak Firik on 11/30/17.
//  Copyright © 2017 Code Path. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
  
  var items: [Item] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 0
  }
  
  override func viewWillAppear(_ animated: Bool) {
    getItem()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return items.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    
    let item = items[indexPath.row]
    if let title = item.title {
      cell.textLabel?.text = title
    }
  
    return cell
  }
  
  func getItem() {
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
      if let item = try? context.fetch(Item.fetchRequest()) as? [Item] {
        if let itemData = item  {
          items = itemData
          tableView.reloadData()
        }
      }
    }
  }
  
}
