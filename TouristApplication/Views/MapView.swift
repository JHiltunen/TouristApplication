import MapKit
import SwiftUI

struct MapView: View {
    
    private let locationManager = CLLocationManager()
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60.192059, longitude: 24.945831), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region,showsUserLocation: true, userTrackingMode: .constant(.follow))
                .frame(width: 350, height: 350)
            
            Button("Allow Location") {
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.requestWhenInUseAuthorization()
            }
            .padding()
        }
        .padding()
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
