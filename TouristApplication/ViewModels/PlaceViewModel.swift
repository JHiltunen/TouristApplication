import SwiftUI

class PlaceViewModel: ObservableObject {
    // Tells if all records have been loaded. (Used to hide/show activity spinner)
    var placesListFull = false
    // Tracks last page loaded. Used to load next page (current + 1)
    var currentPage = 0
    // Limit of records per page. (Only if backend supports, it usually does)
    let limit = 20
    
    // every time array is updated -> view is going to know it hast to be update itself
    @Published var places: [Data] = []
    
    func fetch() {
        // url to fetch
        let tagsForSearch: String = tags.map {$0.name}.joined(separator: "%2C").replacingOccurrences(of: " ", with: "%2520").replacingOccurrences(of: "é", with: "%C3%A9")
        
        guard let url = URL(string: "http://open-api.myhelsinki.fi/v2/places/?tags_search=\(tagsForSearch)&limit=\(limit)&start=\(currentPage)") else {
            return
        }
        print("request url", url)
        // create the task to get data
        let task = URLSession.shared.dataTask(with: url) { [self] data, response, error in
            if let error = error {
                print("Client error \(error)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                //handle server error
                return
            }
            
            if let data = data, let string = String(data: data, encoding: .utf8) {
                // process the data
                 //print("data: \(data) string:\(string)")
                DispatchQueue.main.async {
                    // in here you could call a method that updates the UI as this vlosure is
                    //dispatched to the main queue
                }
            }
            
            guard let data2 = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let obj = try decoder.decode(Place.self, from: data2)
                
                DispatchQueue.main.async {
                    places.append(contentsOf: obj.data)
                    //print("META", obj.tags)
                    //tags.append(contentsOf: obj.tags)
                    //print("Tags", tags)
                }
                
                // DispatchQueue.global(qos: Dis)
                
                // If count of data received is less than perPage value then it is last page.
                if obj.data.count < self.limit {
                    self.placesListFull = true
                }
                //                print(obj.data)
                //print(obj.tags)
                
                //for result in obj.data {
//                    print("ID \(result.id)")
//                    print("English name \(result.name.en)")
//                    print("Finnish name \(result.name.fi)")
//                    print("Swedish name \(result.name.sv)")
//                    print("Info url \(result.infoUrl)")
//                    print("Latitude \(result.location.lat)")
//                    print("Lognitude \(result.location.lon)")
//                    print("Address \(result.location.address)")
//                    print("Streetaddress \(result.location.address.streetAddress)")
//                    print("Postalcode \(result.location.address.postalCode)")
//                    print("Locality \(result.location.address.locality)")
//                    print("Neighbourhood \(result.location.address.neighbourhood)")
//                    print("Description \(result.description)")
//                    print("Description intro \(result.description.intro)")
//                    print("Description body \(result.description.body)")
                    // print("Tags \(result.tags)")
//                    print("Opening hours url \(result.openingHoursURL)")
//                    // print("(\(result.unit.linkings.taxon.scientificName))")
//                    DispatchQueue.main.async {
//                        self.places = obj.data
//                    }
                //}
                
                currentPage += limit
                print("currentPage: \(currentPage)")
                DispatchQueue.main.async {
                    // self.parliamentLabel.text = "\(member[xx])"
                }
            } catch let err {
                print("Err", err)
            }
        }
        task.resume()
    }
}