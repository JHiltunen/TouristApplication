//
//  PlaceData+CoreDataProperties.swift
//  TouristApplication
//
//  Created by iosdev on 11.12.2021.
//
//

import Foundation
import CoreData


extension PlaceData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlaceData> {
        return NSFetchRequest<PlaceData>(entityName: "PlaceData")
    }

    @NSManaged public var id: String?
    @NSManaged public var infoUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var openingHoursURL: String?
    @NSManaged public var descriptions: PlaceDescription?
    @NSManaged public var location: PlaceLocation?
    @NSManaged public var tags: NSSet?

}

// MARK: Generated accessors for tags
extension PlaceData {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: PlaceTag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: PlaceTag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

extension PlaceData : Identifiable {

}
