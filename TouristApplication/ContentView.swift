import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var viewModel = PlaceViewModel()
    @Environment(\.managedObjectContext) var context
    
    // Fetching Data Fom Core data
    //@FetchRequest(entity: PlaceData.entity(), sortDescriptors: PlaceSort.default.descriptors) var results: //FetchedResults<PlaceData>
    
    @FetchRequest(
        sortDescriptors: PlaceSort.default.descriptors,
      animation: .default)
    private var places: FetchedResults<PlaceData>
    
    var body: some View {
        NavigationView {
            // SpeechRecognitionView()
            
            if places.isEmpty {
                ProgressView()
                // Fetching
                    .onAppear(perform: {
                        viewModel.fetch(context: context)
                    })
                // when array is clear indicator appears
                // as a result data is fetched again
            } else {
                List(places, id: \.self) { data in
                    ListItemView(fetchedData: data)
                }
                .navigationTitle(!places.isEmpty ? "Fetched Core Data" : "Fetched JSON")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            // by clearing array data...
                            // it will auto fetch data again...
                            
                            // Clearing data in core data
                            
                            do {
                                places.forEach { (place) in
                                    context.delete(place)
                                }
                                
                                try context.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                            viewModel.places.removeAll()
                        }, label: {
                            SwiftUI.Image(systemName: "arrow.clockwise.circle")
                                .font(.title)
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
