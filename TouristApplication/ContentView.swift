import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var viewModel = PlaceViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.places, id: \.self) { place in
                    HStack {
                        Text(place.name.en ?? "No name available")
                    }
                }
                if viewModel.placesListFull == false {
                    HStack {
                        Text("Loading... ")
                        ProgressView()
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
