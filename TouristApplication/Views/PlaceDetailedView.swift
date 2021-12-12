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
            VStack(spacing: 15) {
                AsyncImage(url: URL(string: "https://via.placeholder.com/200"))
                Spacer()
                Text(place?.name ?? "No name available")
                    .font(.title)
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
                Text(place?.descriptions?.intro ?? "No Intro available")
                    .font(.body)
                    .padding()
                Text(place?.descriptions?.body ?? "No Description available")
                    .font(.body)
                    .padding()
                MapView()
            }
        }
    }
}
