//
//  MenuItemDetailViewController.swift
//  IOS_Restaurant
//
//  Created by Nguyen Phuc on 4/27/21.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
  var menuItem: MenuItem!
  @IBOutlet var detailTextLabel: UILabel!
  @IBOutlet var priceLabel: UILabel!
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var addToOrderButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addToOrderButton.layer.cornerRadius = 5.0
    updateUI()
  }
  
  func updateUI(){
    titleLabel.text = menuItem.name
    priceLabel.text = String(format: "$%.2f", menuItem.price)
    detailTextLabel.text = menuItem.detailText
    MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
      guard let image = image else { return }
      DispatchQueue.main.async {
        self.imageView.image = image
      }
    }
  }
  
  
  @IBAction func orderButtonTapped(_ sender: UIButton) {
    UIView.animate(withDuration: 0.3) {
      self.addToOrderButton.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
      self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
    }
    MenuController.shared.order.menuItems.append(menuItem)
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
