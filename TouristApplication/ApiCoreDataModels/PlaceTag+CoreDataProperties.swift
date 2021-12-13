import Foundation
import CoreData


extension PlaceTag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlaceTag> {
        return NSFetchRequest<PlaceTag>(entityName: "PlaceTag")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var place: NSSet?

}

// MARK: Generated accessors for place
extension PlaceTag {

    @objc(addPlaceObject:)
    @NSManaged public func addToPlace(_ value: PlaceData)

    @objc(removePlaceObject:)
    @NSManaged public func removeFromPlace(_ value: PlaceData)

    @objc(addPlace:)
    @NSManaged public func addToPlace(_ values: NSSet)

    @objc(removePlace:)
    @NSManaged public func removeFromPlace(_ values: NSSet)

}

extension PlaceTag : Identifiable {

}
