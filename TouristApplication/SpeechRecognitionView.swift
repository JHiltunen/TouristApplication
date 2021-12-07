import SwiftUI
import CoreData

struct SpeechRecognitionView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.created, ascending: true)],
        animation: .default)
    private var todos: FetchedResults<Todo>
    
    @State private var recording = false
    
    @ObservedObject private var mic = MicMonitor(numberOfSamples: 15)
    
    private var speechManager = SpeechManager()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                List {
                    ForEach(todos) { item in
                        Text(item.text ?? " - ")
                    }
                    .onDelete(perform: deleteItems)
                }
                .navigationTitle("Speech to Text")
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.primary.opacity(0.5))
                    .padding()
                    .overlay(VStack {
                        visualizerView()
                    })
                    .opacity(recording ? 1 : 0)
                
                VStack {
                    recordButton()
                }
            } .onAppear {
                speechManager.checkPermission()
            }
    }
}
    
    private func recordButton() -> some View {
        Button(action: addItem) {
            Image(systemName: recording ? "xmark" : "mic.fill")
                .font(.system(size: 40))
                .padding()
        } .foregroundColor(.black)
    }

private func normalizedSoundLevel(level: Float) -> CGFloat {
    let level = max(0.2, CGFloat(level) + 50) / 2
    return CGFloat(level * (100 / 25))
}

private func visualizerView() -> some View {
        VStack {
            HStack(spacing: 4) {
                ForEach(mic.soundSamples, id: \.self) {level in
                    VisualBarView(value: self.normalizedSoundLevel(level: level))
            }
        }
    }
}
                                  
    private func addItem() {
        if speechManager.isRecording {
            self.recording = false
            mic.stopMonitoring()
            speechManager.stopRecording()
        } else {
            self.recording = true
            mic.startMonitoring()
            speechManager.start { (speechText) in
                guard let text = speechText, !text.isEmpty else {
                    self.recording = false
                    return
                }
                
                DispatchQueue.main.async {
                    withAnimation {
                        let newItem = Todo(context: viewContext)
                        newItem.id = UUID()
                        newItem.text = text
                        newItem.created = Date()
                        
                        
                        do {
                            try viewContext.save()
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
        
        speechManager.isRecording.toggle()
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { todos[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                print(error)
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

