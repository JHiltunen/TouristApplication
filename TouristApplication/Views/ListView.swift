import SwiftUI

struct ListView: View {
    @StateObject var viewModel = PlaceViewModel()
    @Environment(\.managedObjectContext) var context
    
    @State private var selectedSort = PlaceSort.default
    @State private var searchTerm = ""
    @State private var selectedIndex: Int = 0
    @State private var selectedCategory = "All"
    
    @FetchRequest(
        sortDescriptors: PlaceSort.default.descriptors,
        animation: .default)
    private var places: FetchedResults<PlaceData>
    
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
            let searchPredicate = NSPredicate(
                format: "name contains[cd] %@",
                newValue)
            let categoryPredicate = NSPredicate(format: "any tags.name contains[cd] %@", selectedCategory)
            
            let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [searchPredicate, categoryPredicate])
            
            places.nsPredicate = selectedCategory == "All" ? searchPredicate : compound
        }
    }
    var body: some View {
        if viewModel.places.isEmpty {
            ProgressView()
            // Fetching
                .onAppear(perform: {
                    viewModel.fetch(context: context)
                })
            // when array is clear indicator appears
            // as a result data is fetched again
        } else {
            VStack(spacing: 20) {
                HorizontalPickerView(selectedIndex: $selectedIndex)
                    .onChange(of: selectedIndex) { V in
                        let selectedTagName = tags[selectedIndex].name
                        selectedCategory = selectedTagName
                        places.nsPredicate = selectedTagName == "All" ? nil : NSPredicate(format: "any tags.name contains[cd] %@", selectedCategory)
                    }
                    .frame(height: 20)
                Spacer()
                List(places, id: \.self) { data in
                    ListItemView(fetchedData: data)
                }
                .searchable(text: searchQuery, placement: .navigationBarDrawer(displayMode: .always))
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
                            DispatchQueue.main.async {
                                do {
                                    places.forEach { (place) in
                                        context.delete(place)
                                    }
                                    viewModel.places.removeAll()
                                    
                                    try context.save()
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        }, label: {
                            SwiftUI.Image(systemName: "arrow.clockwise.circle")
                        })
                    }
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
