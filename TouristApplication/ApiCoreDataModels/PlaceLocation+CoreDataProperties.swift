import Foundation
import CoreData


extension PlaceLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlaceLocation> {
        return NSFetchRequest<PlaceLocation>(entityName: "PlaceLocation")
    }

    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var address: PlaceAdress?
    @NSManaged public var place: PlaceData?

}

extension PlaceLocation : Identifiable {

}
