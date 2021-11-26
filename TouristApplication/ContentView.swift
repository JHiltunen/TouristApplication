import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var viewModel = PlaceViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.places, id: \.self) { place in
                    HStack {
                        // if no english name fallback to finnish name
                        Text(place.name.en ?? place.name.fi ?? "No name available")
                    }
                }
                // if list of places isn't full
                if viewModel.placesListFull == false {
                    // Render spinner to indicate loading more places is in progress
                    HStack {
                        Text("Loading... ")
                        ProgressView()
                            // perform the fetch when ProgressView appears
                            .onAppear(perform: {
                                self.viewModel.fetch()
                            })
                    }
                }
            }
        }
        .navigationTitle("Places")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
