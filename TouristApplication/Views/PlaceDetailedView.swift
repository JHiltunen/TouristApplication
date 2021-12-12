//
//  PlaceDetailedView.swift
//  TouristApplication
//
//  Created by iosdev on 12.12.2021.
//

import SwiftUI

struct PlaceDetailedView: View {
    var place: PlaceData?
    var body: some View {
        ScrollView {
            Text(place?.name ?? "No name available")
                .font(.title)
            Spacer()
            VStack(spacing: 15) {
                NavigationLink(place?.infoUrl ?? "No url", destination: {
                    WebView(url: URL(string: place?.infoUrl ?? "https://www.google.com")!)
                })
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
                MapView()
            }
        }
    }
}
