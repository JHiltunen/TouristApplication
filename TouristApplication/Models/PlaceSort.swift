//
//  PlaceSort.swift
//  TouristApplication
//
//  Created by iosdev on 8.12.2021.
//

import Foundation

// 1. Conform to Hashable and Identifiable. This is necessary to use PlaceSort in a SwiftUI view for selecting sorts from a menu.
struct PlaceSort: Hashable, Identifiable {
    // 2.Add id to conform to Identifiable.
    let id: Int
    // 3. name is the friendly name of the sort shown in the sort menu.
    let name: String
    // 4. descriptors are the SortDescriptors to apply.
    let descriptors: [SortDescriptor<PlaceData>]
    let section: KeyPath<PlaceData, String>
    
    // 1. It adds a static property to allow easy access to sorts from a SwiftUI View.
    static let sorts: [PlaceSort] = [
        // 2. It returns an array of FriendSort items.
        PlaceSort(
            id: 0,
            name: "Place name | Ascending",
            // 3. Each SortDescriptor specifies the keypath to sort on and the order in which to sort. Note the new SortDescriptor API introduces the .forward and .reverse enumeration values instead of the old Boolean-based sort direction specifier. Each option has a primary sort descriptor and a second one for cases where the first value is the same, such as when you meet lots of people in the same place.
            descriptors: [
                SortDescriptor(\PlaceData.name, order: .forward)
                //SortDescriptor(\PlaceData.name, order: .forward)
            ],
            section: \PlaceData.name),
        PlaceSort(
            id: 1,
            name: "Place name | Descending",
            descriptors: [
                SortDescriptor(\PlaceData.name, order: .reverse)
                //SortDescriptor(\PlaceData.name, order: .forward)
            ],
            section: \PlaceData.name),
        PlaceSort(
            id: 2,
            name: "Meeting Date | Ascending",
            descriptors: [
                SortDescriptor(\PlaceData.name, order: .forward),
                SortDescriptor(\PlaceData.name, order: .forward)
            ],
            section: \PlaceData.name),
        PlaceSort(
            id: 3,
            name: "Meeting Date | Descending",
            descriptors: [
                SortDescriptor(\PlaceData.name, order: .reverse),
                SortDescriptor(\PlaceData.name, order: .forward)
            ],
            section: \PlaceData.name),
    ]
    
    // 4. This static property is used as the initial sort option.
    static var `default`: PlaceSort { sorts[0] }
}
