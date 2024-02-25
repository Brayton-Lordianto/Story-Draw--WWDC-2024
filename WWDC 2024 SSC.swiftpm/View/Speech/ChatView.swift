import SwiftUI

struct Chat: View {
    @State private var recording = false
    @ObservedObject private var mic = MicManager(numberOfSamples: 30)
    private var speechManager = SpeechManager()
    @State var count = 0
    @State var isShowingChat = false 
    let arr = ["bonjour", "pitch", "chat"]
    
    
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
//                viewModel.Dialog = text
                print(text)
            }
        }
        speechManager.isRecording.toggle()
    }
    private func recordButton() -> some View {
        Button(action: {
            Transcribing()
        }) {
            Image(systemName: recording ? "stop.circle.fill" : "mic.circle")
                .font(.system(size: 40))
                .padding()
                .cornerRadius(10)
            
        }
        .foregroundColor(.red)
    }
}

#Preview(body: { 
    Chat()
})
