import SwiftUI
import Speech

struct Speech: View {
    
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keupath: \Todo.create, ascennding: true)], animation: .default) private var todos: FetchedResults<Todo>
    
    @State private var recording = false
    
    // @ObservedObject private var mic = MicMonitor(numberOfSamples: 30)
    
    private var speechManager = SpeechManager()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                List {
                    ForEach(todos) { item in
                        Text(item.text ?? " - ")
                    }
                    .onDelete(perform: deleteItems)
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map {todos[$0].forEach(viewContext.delete)
                
                do {
                    try viewContext.save()
                } catch {
                    print(error)
                }
            }
        }
    }
}

struct Speech_Previews: PreviewProvider {
    static var previews: some View {
        Speech()
    }
}
