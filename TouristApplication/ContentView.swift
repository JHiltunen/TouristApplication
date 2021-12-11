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
    @State private var searchTerm = ""
    
    var searchQuery: Binding<String> {
      Binding {
        // 1. Creates a binding on the searchTerm property.
        searchTerm
      } set: { newValue in
        // 2. Whenever searchQuery changes, it updates searchTerm.
        searchTerm = newValue
        
        // 3. If the string is empty, it removes any existing predicate on the fetch. This removes any existing filters and displays the complete list of Places.
        guard !newValue.isEmpty else {
          places.nsPredicate = nil
          return
        }

        // 4. If the search term isn’t empty, it creates a predicate with the search term as criteria and applies it to the fetch request.
        places.nsPredicate = NSPredicate(
          format: "name contains[cd] %@",
          newValue)
      }
    }
    
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
                .searchable(text: searchQuery)
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
