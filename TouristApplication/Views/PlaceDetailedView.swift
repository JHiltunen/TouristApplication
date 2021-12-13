import SwiftUI

// Shows etailed information of place
struct PlaceDetailedView: View {
    var place: PlaceData?
    var body: some View {
        ScrollView {
            Text(place?.name ?? "No name available")
                .font(.title)
            Spacer()
            VStack(spacing: 15) {
                // Render NavigationLink if there is infoUrl provided on data
                if !(place?.infoUrl?.isEmpty ?? true) {
                    NavigationLink(place?.infoUrl ?? "No url", destination: {
                        WebView(url: URL(string: place?.infoUrl ?? "https://www.google.com")!)
                    })
                }
                HStack {
                    SwiftUI.Image(systemName: "mappin.and.ellipse")
                        .font(.subheadline)
                    Text(place?.location?.address?.streetAddress ?? "No address available")
                        .font(.subheadline)
                    Text(place?.location?.address?.postalCode ?? "No postalcode available")
                        .font(.subheadline)
                    Text(place?.location?.address?.locality ?? "No locality available")
                        .font(.subheadline)
                }
                Text(place?.descriptions?.body ?? "No Description available")
                    .font(.body)
                    .padding()
                MapView(lat: place?.location?.lat ?? 60.192059, long: place?.location?.lon ?? 24.945831)
            }
        }
    }
}
