//
//  PlaceDescription+CoreDataProperties.swift
//  TouristApplication
//
//  Created by iosdev on 11.12.2021.
//
//

import Foundation
import CoreData


extension PlaceDescription {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlaceDescription> {
        return NSFetchRequest<PlaceDescription>(entityName: "PlaceDescription")
    }

    @NSManaged public var body: String?
    @NSManaged public var intro: String?
    @NSManaged public var images: NSSet?
    @NSManaged public var place: PlaceData?

}

// MARK: Generated accessors for images
extension PlaceDescription {

    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: PlaceImage)

    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: PlaceImage)

    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSSet)

    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSSet)

}

extension PlaceDescription : Identifiable {

}
