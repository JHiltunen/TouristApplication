//
//  Tags.swift
//  TouristApplication
//
//  Created by iosdev on 26.11.2021.
//

import SwiftUI

var tags: [Tag] = [Tag(id: 0, name: "cafés"), Tag(id: 1, name: "shops and outlets"), Tag(id: 2, name: "cultural history museums"),
                   Tag(id: 3, name: "sights"), Tag(id: 4, name: "shopping"), Tag(id: 5, name: "restaurants"),
                   Tag(id: 6, name: "saunas for rent"), Tag(id: 7, name: "wellness"), Tag(id: 8, name: "venues"),
                   Tag(id: 9, name: "bars and pubs"), Tag(id: 10, name: "galleries"), Tag(id: 11, name: "nature"),
                   Tag(id: 12, name: "sports"), Tag(id: 13, name: "activity places"), Tag(id: 14, name: "night clubs"),
                   Tag(id: 15, name: "study"), Tag(id: 16, name: "work"), Tag(id: 17, name: "museums")]

struct Tag: Hashable, Codable {
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
