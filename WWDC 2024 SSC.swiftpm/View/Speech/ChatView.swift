import SwiftUI
import Speech 
import AVFoundation
import Foundation

struct debug { 
    static var second = false 
}

public struct Chat: View {
//    @StateObject var dvm: DrawingViewModel
//    var idx: Int 
    @Binding var imageToOverlay: UIImage? 
    @Binding var drawing: DrawingModel
    @State public var STIManager: SpeechToImageVM
    @State private var isRecording = false
    @State private var mic = MicManager(numberOfSamples: 30)
    @State private var speechManager = SpeechManager() 
    @State var count = 0
    @State var isShowingChat = false 
    @State var recognizedText = ""
    @State var speechRecognizer = SpeechRecognizer()
    @State var AudioEngine = AVAudioEngine()
    
    public var body: some View {
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
               let img = STIManager.processSpeechToText(speech: transcript)
               imageToOverlay = img
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
//
//#Preview(body: { 
////    Chat(drawing: .constant(sampleDrawing), STIManager: .init(drawing: .constant(sampleDrawing)))
//})
