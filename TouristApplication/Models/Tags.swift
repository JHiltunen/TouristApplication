//
//  Tags.swift
//  TouristApplication
//
//  Created by iosdev on 26.11.2021.
//

import SwiftUI

var tags: [Tag] = [Tag(id: "main:239", name: "cafés"), Tag(id: "main:256", name: "shops and outlets"), Tag(id: "main:344", name: "cultural history museums"),
                   Tag(id: "main:473", name: "sights"), Tag(id: "main:490", name: "shopping"), Tag(id: "main:577", name: "restaurants"),
                   Tag(id: "main:804", name: "saunas for rent"), Tag(id: "main:864", name: "wellness"), Tag(id: "main:868", name: "venues"),
                   Tag(id: "main:869", name: "bars and pubs"), Tag(id: "main:915", name: "galleries"), Tag(id: "main:916", name: "nature"),
                   Tag(id: "main:917", name: "sports"), Tag(id: "main:918", name: "activity places"), Tag(id: "main:919", name: "night clubs"),
                   Tag(id: "main:920", name: "study"), Tag(id: "main:921", name: "work"), Tag(id: "main:961", name: "museums")]

struct Tag: Hashable, Codable {
    var id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
