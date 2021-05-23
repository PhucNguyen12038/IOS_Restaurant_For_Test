//
//  MenuItem.swift
//  IOS_Restaurant
//
//  Created by Nguyen Phuc on 4/26/21.
//

import Foundation

// Inherit from Codable to convert non-matching name between JSON and property name
struct MenuItem: Codable {
    var id: Int
    var name: String
    var price: Double
    var detailText: String
    var imageURL: URL
    var category: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case category
        case detailText = "description"
        case imageURL = "image_url"
    }
}

struct MenuItems: Codable {
    var items: [MenuItem]
}
