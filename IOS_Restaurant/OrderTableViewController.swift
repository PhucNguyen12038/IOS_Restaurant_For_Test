//
//  OrderTableViewController.swift
//  IOS_Restaurant
//
//  Created by Nguyen Phuc on 4/26/21.
//

import UIKit

class OrderTableViewController: UITableViewController {
  var orderMinutes = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(tableView!, selector: #selector(UITableView.reloadData), name: MenuController.orderUpdateNotification, object: nil)
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MenuController.shared.order.menuItems.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCellIdentifier", for: indexPath)
    
    configure(cell, forItemAt: indexPath)
    
    return cell
  }
  
  func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath){
    let menuItem = MenuController.shared.order.menuItems[indexPath.row]
    cell.textLabel?.text = menuItem.name
    cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
  }
  
  // Override to support conditional editing of the table view.
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  
  // Override to support editing the table view.
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      MenuController.shared.order.menuItems.remove(at: indexPath.row)
    }
  }
  
  
  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  
  // MARK: - Navigation
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ConfirmationSegue" {
      let orderConfirmationViewController = segue.destination as! OrderConfirmationViewController
      orderConfirmationViewController.minutes = self.orderMinutes
    }
  }
  
  @IBAction func submitTapped(_ sender: Any) {
    let orderTotal = MenuController.shared.order.menuItems.reduce(0.0){ (result, menuItem) -> Double in
      return result + menuItem.price
      
    }
    let formattedOrder = String(format: "$%.2f", orderTotal)
    let alert = UIAlertController(title: "Confirm Order", message: "You are about to submit order with a total of \(formattedOrder)", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Submit", style: .default) { (action) in
      self.uploadOrder()
    })
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
  
  func uploadOrder() {
    let menuIds = MenuController.shared.order.menuItems.map(){$0.id}
    MenuController.shared.submitOrder(forMenuIDs: menuIds) { (minutes) in
      DispatchQueue.main.async {
        if let minutes = minutes {
          self.orderMinutes = minutes
          self.performSegue(withIdentifier: "ConfirmationSegue", sender: nil)
        }
      }
    }
  }
  
  
  @IBAction func unwindToOrderList(segue: UIStoryboardSegue){
    if segue.identifier == "DismissConfirmation" {
      MenuController.shared.order.menuItems.removeAll()
    }
  }
  
  
}
