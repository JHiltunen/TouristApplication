
import Foundation
import Speech

class SpeechManager {
    
    var isRecording = false
    var audioEngine: AVAudioEngine!
    var inputNote: AVAudioInputNode!
    var audioSession: AVAudioSession!
    
    var recognitionRequist: SFSpeechAudioBufferRecognitionRequest?
    
    func checkPermissions() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            DispatchQueue.main.async {
                switch authStatus {
                case . authorized: break
                default:
                    print("Speech recognition is not available")
                }
            }
        }
    }
    
    func start(completion: @escaping (String?) -> Void) {
        if isRecording {
            stopRecording()
        } else {
            startRecording(completion: completion)
        }
    }
    
    func startRecording(completion: @escaping (String?) -> Void) {
        guard let recognizer = SFSpeechRecognizer(), recognizer.isAvailable
        else {
            print("Speech recognition is not available")
            return
        }
        
        recognitionRequist = SFSpeechAudioBufferRecognitionRequest()
        recognitionRequist!.shouldReportPartialResults = true
        
        recognizer.recognitionTask(with: recognitionRequist!) { (result, error) in
            guard error == nil
            else {
                return
            }
            
            guard let result = result else {
                return
            }
            
            if result.isFinal {
                completion(result.bestTranscription.formattedString)
            }
        }
        
        audioEngine = AVAudioEngine()
        inputNote = audioEngine.inputNode
        let recordingFormat = inputNote.outputFormat(forBus: 0)
        inputNote.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {
            (buffer, _) in self.recognitionRequist?.append(buffer)
        }
    }
    
    func stopRecording() {
        recognitionRequist?.endAudio()
        recognitionRequist = nil
        audioEngine.stop()
        inputNote.removeTap(onBus: 0)
        
        try? audioSession.setActive(false)
        audioSession = nil
    }
}
