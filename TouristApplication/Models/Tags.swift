//
//  Tags.swift
//  TouristApplication
//
//  Created by iosdev on 26.11.2021.
//

import SwiftUI

var tags: [Tag] = [Tag(id: 0, name: "All"), Tag(id: 1, name: "cafés"), Tag(id: 2, name: "shops and outlets"), Tag(id: 3, name: "cultural history museums"),
                   Tag(id: 4, name: "sights"), Tag(id: 5, name: "shopping"), Tag(id: 6, name: "restaurants"),
                   Tag(id: 7, name: "saunas for rent"), Tag(id: 8, name: "wellness"), Tag(id: 9, name: "venues"),
                   Tag(id: 10, name: "bars and pubs"), Tag(id: 11, name: "galleries"), Tag(id: 12, name: "nature"),
                   Tag(id: 13, name: "sports"), Tag(id: 14, name: "activity places"), Tag(id: 15, name: "night clubs"),
                   Tag(id: 16, name: "study"), Tag(id: 17, name: "work"), Tag(id: 18, name: "museums")]

struct Tag: Hashable, Codable {
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

struct ApiTag: Hashable, Codable {
    var id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
