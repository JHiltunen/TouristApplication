import MapKit
import SwiftUI

struct IdentifiablePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
}

struct MapView: View {
    
    let place: IdentifiablePlace
    var coordinate: CLLocationCoordinate2D
    
    private let locationManager = CLLocationManager()
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60.192059, longitude: 24.945831), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    init(lat: Double, long: Double) {
        self.place = IdentifiablePlace(lat: lat, long: long)
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region,
                showsUserLocation: true,
                userTrackingMode: .constant(.follow),
                annotationItems: [place]) { place in
                    MapPin(coordinate: place.location, tint: Color.red)
                    
            }
                .onAppear {
                    setRegion(coordinate)
                }
                .frame(width: 350, height: 350)
        }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
    }
}
