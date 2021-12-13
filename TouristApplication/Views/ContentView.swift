import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
//        HorizontalPickerView(selectedIndex: $selectedIndex)
//            .onChange(of: selectedIndex) { V in
//                let selectedTagName = tags[selectedIndex].name
//                selectedCategory = selectedTagName
//                places.nsPredicate = selectedTagName == "All" ? nil : NSPredicate(format: "any tags.name contains[cd] %@", selectedCategory)
//            }
        TabView {
            NavigationView {
                ListView()
                    .navigationBarTitle("Places")
            }
            .tabItem { //note how this is modifying `NavigationView`
                SwiftUI.Image(systemName: "house")
                Text("Home")
            }
            SpeechRecognitionView()
            .tabItem { //note how this is modifying `NavigationView`
                SwiftUI.Image(systemName: "mic")
                Text("Speech to text")
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
