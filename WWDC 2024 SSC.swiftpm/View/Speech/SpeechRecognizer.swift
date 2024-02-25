import Foundation
import Speech

class SpeechManager {
    public var isRecording = false
    private var audioEngine: AVAudioEngine!
    private var inputNote: AVAudioInputNode!
    private var audioSession: AVAudioSession!
    
    var speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en_IN"))
    
    private var recognitionTask: SFSpeechRecognitionTask?
    
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    func checkPermissions() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            DispatchQueue.main.async {
                switch authStatus {
                case .authorized: break
                default:
                    print("Speech recognition is not available")
                }
            }
        }
    }
    
    func start(completion: @escaping(String?) -> Void) {
        if isRecording {
            stopRecording()
        } else {
            startRecording(completion: completion)
        }
    }
    
    func startRecording(completion: @escaping (String?) -> Void) {
        guard let recognizer = SFSpeechRecognizer(), recognizer.isAvailable else {
            print("Speech recognition is not available")
            return
        }
        
        audioEngine = AVAudioEngine()
        inputNote = audioEngine.inputNode
        let recordingFormat = inputNote.outputFormat(forBus: 0)
        inputNote.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            audioSession = AVAudioSession.sharedInstance()
            try audioEngine.start()
            try audioSession.setCategory(.record, mode: .spokenAudio, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            
        } catch {
            print(error)
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        recognitionRequest!.shouldReportPartialResults = true
        
        recognizer.recognitionTask(with: recognitionRequest!) { (result, error) in
            guard error == nil else {
                print("got error hh \(error!.localizedDescription)")
                return
            }
            
            guard let result = result else {return}
            
            if result.isFinal {
                completion(result.bestTranscription.formattedString)
            }
        }
    }
    
    func stopRecording() {
        recognitionRequest?.endAudio()
        recognitionRequest = nil
        audioEngine.stop()
        inputNote.removeTap(onBus: 0)
        
        try? audioSession.setActive(false)
        audioSession = nil
        
    }
}
