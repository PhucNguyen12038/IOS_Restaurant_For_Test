//
//  MenuController.swift
//  IOS_Restaurant
//
//  Created by Nguyen Phuc on 4/26/21.
//

import Foundation
import UIKit

class MenuController {
  // force unwrap not null value, if null error runtime
  let baseURL = URL(string: "http://localhost:8090/")!
  // static var can be called with class
  static let shared = MenuController()
  var order = Order() {
    didSet {
      NotificationCenter.default.post(name: MenuController.orderUpdateNotification, object: nil)
    }
    
  }
  static let orderUpdateNotification = Notification.Name("MenuController.orderUpdated")
  
  func fetchCategories(completion: @escaping([String]?) -> Void) {
    let categoryURL = baseURL.appendingPathComponent("categories")
    let task = URLSession.shared.dataTask(with: categoryURL){ (data, response, error) in
      let jsonDecoder = JSONDecoder()
      if let data = data,
         let jsonDictionary = try? jsonDecoder.decode(Categories.self, from: data) {
        completion(jsonDictionary.categories)
      } else {
        completion(nil)
      }
    }
    task.resume()
  }
  
  func fetchMenuItems(forCategory categoryName: String, completion: @escaping([MenuItem]?) -> Void) {
    let initialMenuURL = baseURL.appendingPathComponent("menu")
    var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
    components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
    let menuURL = components.url!
    let task = URLSession.shared.dataTask(with: menuURL){ (data, response, error) in
      let jsonDecoder = JSONDecoder()
      if let data = data,
         let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
        completion(menuItems.items)
      } else {
        completion(nil)
      }
    }
    task.resume()
  }
  
  func fetchImage(url: URL, completion: @escaping(UIImage?) -> Void) {
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let data = data,
         let image = UIImage(data: data) {
          completion(image)
      } else {
        completion(nil)
      }
    }
    task.resume()
  }
  /*
  func submitOrder(forMenuIDs menuIds: [Int], completion: @escaping(Int?) -> Void){
    let orderURL = baseURL.appendingPathComponent("order")
    var request = URLRequest(url: orderURL)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let data: [String: [Int]] = ["menuIds": menuIds]
    let jsonEncoder = JSONEncoder()
    let jsonData = try? jsonEncoder.encode(data)
    request.httpBody = jsonData
    let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
      let jsonDecoder = JSONDecoder()
      if let data = data,
         let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data) {
        completion(preparationTime.prepTime)
      } else {
        completion(nil)
      }
    }
    task.resume()
  }
 */
  func submitOrder(forMenuIDs menuIds: [Int], completion: @escaping (Int?) -> Void){
    let orderURL = baseURL.appendingPathComponent("order")
    // change to POST Method
    var request = URLRequest(url: orderURL)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let data: [String:[Int]] = ["menuIds": menuIds]
    let jsonEncoder = JSONEncoder()
    let jsonData = try? jsonEncoder.encode(data)
    request.httpBody = jsonData
    let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
      let jsonDecoder = JSONDecoder()
      if let data = data,
         let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data) {
        completion(preparationTime.prepTime)
      } else {
        completion(nil)
      }
    }
    task.resume()
    
  }
}
