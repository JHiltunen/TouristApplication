import SwiftUI

// View that shows sort options
struct SortSelectionView: View {
    
    // 1. Creates a binding for the currently selected sort item.
    @Binding var selectedSortItem: PlaceSort
    // 2. Creates the array to provide the list of sorts to the view.
    let sorts: [PlaceSort]
    
    var body: some View {
        // 1. Builds a Menu to list the sort options.
        Menu {
          // 2. Presents a Picker and passes the selectedSortItem as the binding.
          Picker("Sort By", selection: $selectedSortItem) {
            // 3. Uses the sorts array as the source of data for the picker.
            ForEach(sorts, id: \.self) { sort in
              // 4. Presents the name of the FriendSort as the menu item text.
              Text("\(sort.name)")
            }
          }
          // 5. Shows a view with an icon and the word Sort as the label.
        } label: {
          Label(
            "Sort",
            systemImage: "line.horizontal.3.decrease.circle")
        }
        // 6. Sets the picker style to .inline, so it displays a list immediately without any other interaction required.
        .pickerStyle(.inline)
    }
}

struct SortSelectionView_Previews: PreviewProvider {
    @State static var sort = PlaceSort.default
    static var previews: some View {
        SortSelectionView(
            selectedSortItem: $sort,
            sorts: PlaceSort.sorts)
    }
}
