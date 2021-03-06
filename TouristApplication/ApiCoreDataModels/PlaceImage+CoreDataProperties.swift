import Foundation
import CoreData


extension PlaceImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlaceImage> {
        return NSFetchRequest<PlaceImage>(entityName: "PlaceImage")
    }

    @NSManaged public var copyrightHolder: String?
    @NSManaged public var mediaId: String?
    @NSManaged public var url: String?
    @NSManaged public var image: PlaceDescription?

}

extension PlaceImage : Identifiable {

}
