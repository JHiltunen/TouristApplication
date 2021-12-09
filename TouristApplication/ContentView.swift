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
    @State private var selectedSort = PlaceSort.default
    
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
                    // 1. Instead of separating ToolbarItem wrappers, it embeds the two views for the toolbar in a ToolbarItemGroup and applies .navigationBarTrailing placement. The ToolbarItemGroup cuts down on a little bit of unnecessary code.
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        // 2. It adds a SortSelectionView as the first toolbar item. Passes in selectedSort property as the binding for the PickerView.
                        SortSelectionView(
                            selectedSortItem: $selectedSort,
                            sorts: PlaceSort.sorts)
                        // 3. On change of the selected sort, it gets the SortDescriptors from the selected sort and applies them to the fetched friends list.
                            .onChange(of: selectedSort) { _ in
                                places.sortDescriptors = selectedSort.descriptors
                            }
                        // 4. Inserts the Reload button toolbar element after the Sort view.
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
