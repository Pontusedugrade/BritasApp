//
//  Item.swift
//  BritasApplication
//
//  Created by Pontus Berggren on 2024-01-03.
//

import Foundation
import SwiftData

@Model
class Item {
    var name: String
    var about: String
    var timestamp: Date
    var category: String
    var isDone: Bool
    
    @Attribute(.externalStorage)
    var image: [Data]
    
    
    init(name: String = "", about: String = "", timestamp: Date = .now, category: String = "",isDone: Bool = false, image: [Data] = []) {
        self.name = name
        self.about = about
        self.timestamp = timestamp
        self.category = category
        self.isDone = isDone
        self.image = image
        
    }
}
