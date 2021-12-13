import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        // Create tab bar to bottom of screen
        TabView {
            NavigationView {
                ListView()
                    .navigationBarTitle("Places")
            }
            // Home tab
            .tabItem {
                SwiftUI.Image(systemName: "house")
                Text("Home")
            }
            // Speech to text tab
            SpeechRecognitionView()
                .tabItem {
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
