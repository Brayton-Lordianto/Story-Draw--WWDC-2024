import SwiftUI
import Speech 
import AVFoundation
import Foundation

struct debug { 
    static var second = false 
}

struct Chat: View {
    @State public var STIManager: SpeechToImageVM
    @State private var isRecording = false
    @State private var mic = MicManager(numberOfSamples: 30)
    @State private var speechManager = SpeechManager() 
    @State var count = 0
    @State var isShowingChat = false 
    @State var recognizedText = ""
    @State var speechRecognizer = SpeechRecognizer()
    @State var AudioEngine = AVAudioEngine()
    
    init(STIManager: SpeechToImageVM) {
        self.STIManager = STIManager 
    }
    
    var body: some View {
        ZStack {
            
            VStack {
                recordButton()
                    .padding(.bottom, 30)
            }
        }
        .onAppear {
            speechManager.checkPermissions()
        }
        
    }
    private func Transcribing() {
        self.isRecording.toggle()
        if isRecording { 
            Task { 
                await speechRecognizer.resetTranscript()
                await speechRecognizer.startTranscribing()
            }
        } else { 
           Task { 
               await speechRecognizer.stopTranscribing()
               let transcript = await speechRecognizer.transcript
               
           }
        }
    }
    
    private func recordButton() -> some View {
        Button(action: {
            Transcribing()
        }) {
            Image(systemName: isRecording ? "stop.circle.fill" : "mic.circle")
                .font(.system(size: 40))
                .padding()
                .cornerRadius(10)
            
        }
        .foregroundColor(.red)
    }
}

#Preview(body: { 
    Chat(STIManager: .init(drawing: .constant(sampleDrawing)))
})
