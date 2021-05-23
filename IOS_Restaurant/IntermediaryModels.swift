//
//  IntermediaryModels.swift
//  IOS_Restaurant
//
//  Created by Nguyen Phuc on 4/26/21.
//

import Foundation

// Inherit from Codable because getting data from server and decode
struct Categories: Codable {
    let categories: [String]
}

struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
