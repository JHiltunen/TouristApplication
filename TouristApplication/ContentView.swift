import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var viewModel = PlaceViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.places, id: \.self) { place in
                    HStack {
                        Text(place.data.name)
                        Text(place.data.description.intro)
                    }
                }
            }
            .navigationTitle("Places")
            .onAppear {
                viewModel.fetch()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
