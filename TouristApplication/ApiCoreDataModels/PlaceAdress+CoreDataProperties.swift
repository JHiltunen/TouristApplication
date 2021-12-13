import Foundation
import CoreData


extension PlaceAdress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlaceAdress> {
        return NSFetchRequest<PlaceAdress>(entityName: "PlaceAdress")
    }

    @NSManaged public var locality: String?
    @NSManaged public var neighbourhood: String?
    @NSManaged public var postalCode: String?
    @NSManaged public var streetAddress: String?
    @NSManaged public var location: PlaceLocation?

}

extension PlaceAdress : Identifiable {

}
