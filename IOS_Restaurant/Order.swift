//
//  Order.swift
//  IOS_Restaurant
//
//  Created by Nguyen Phuc on 4/26/21.
//

import Foundation

struct Order {
    var menuItems: [MenuItem]
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
