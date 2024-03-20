//
//  ContentView.swift
//  testAudio
//
//  Created by 1 on 20.03.2024.
//

import SwiftUI
import AVFoundation


struct ContentView: View {
    @StateObject var viewModel = AudioPlayerViewModel()
    @State var pitchEffect: Int = 1
        @State var speedEffect: Int = 1
    let array = Array(-240...240)
    let array2 = Array(1...32)

    var body: some View {
        VStack {
            Picker("Частота", selection: $pitchEffect) {
                ForEach(array, id: \.self) { num in
                    Text("\(num)").tag(num)
                }
            }
            
            Picker("", selection: $speedEffect) {
                ForEach(array2, id: \.self) { num in
                    Text("\(num)").tag(num)
                }
            }
            
            HStack(spacing: 40) {
                Button {
                    viewModel.playAudio(pitchEffectValue: Float(pitchEffect), speedEffectValue: Float(speedEffect))
                } label: {
                    Text("Play")
                }
                
                Button {
                } label: {
                    Text("Pause")
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
