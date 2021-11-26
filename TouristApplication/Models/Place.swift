import SwiftUI
import Combine

struct Place: Codable, Hashable {
    let meta: Meta
    let data: [Data]
}

struct Meta: Hashable, Codable {
    let count: String
}

struct Data: Hashable, Codable {
    var id: String
    var name: Name
    let infoUrl: String
    let location: Location
    let description: Description
    let tags: [Tag]
    let openingHoursURL: String
    
    private enum CodingKeys:String, CodingKey {
        case id
        case name
        case infoUrl = "info_url"
        case location
        case description
        case tags
        case openingHoursURL = "opening_hours_url"
    }
}

struct Name: Hashable, Codable {
    let fi: String?
    let en: String?
    let sv: String?
}

struct Location: Hashable, Codable {
    let lat, lon: Double
    let address: Address
}

struct Address: Hashable, Codable {
    let streetAddress, postalCode, locality, neighbourhood: String
    
    private enum CodingKeys:String, CodingKey {
        case streetAddress = "street_address"
        case postalCode = "postal_code"
        case locality
        case neighbourhood
    }
}

struct Description: Hashable, Codable {
    let intro, body: String
    let images: [Image]
}

struct Image: Hashable, Codable {
    let url: String
    let copyrightHolder: String
    let mediaId: String
    
    private enum CodingKeys:String, CodingKey {
        case url
        case copyrightHolder = "copyright_holder"
        case mediaId = "media_id"
    }
}
