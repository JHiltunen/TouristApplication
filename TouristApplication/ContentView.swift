import SwiftUI
import Foundation
import MapKit

struct ContentView: View {
    @StateObject var viewModel = PlaceViewModel()
    @State private var selectedIndex: Int = 0
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HorizontalPickerView(selectedIndex: $selectedIndex)
                    .frame(height: 30)
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
        }
        //.navigationTitle("Places")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Layout helper
extension View {
    func fillParent(alignment:Alignment = .center) -> some View {
        return GeometryReader { geometry in
            self
                .frame(width: geometry.size.width,
                       height: geometry.size.height,
                       alignment: alignment)
        }
    }
}
