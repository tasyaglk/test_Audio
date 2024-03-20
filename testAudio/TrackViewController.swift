//
//  TrackViewController.swift
//  testAudio
//
//  Created by 1 on 21.03.2024.
//

import Foundation
import AVFAudio

class AudioPlayerViewModel: ObservableObject {
    var engine = AVAudioEngine()
    var playerNode = AVAudioPlayerNode()
    
    func playAudio(soundName: String = "ddd", pitchEffectValue: Float = 100, speedEffectValue: Float = 20) {
        do {
            let file = try! AVAudioFile(forReading: URL(fileURLWithPath: (Bundle.main.path(forResource: soundName, ofType: "mp3")!))) // посмотреть, как доставать файл
            let format = file.processingFormat
            let frameCount = UInt32(file.length)
            let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount)
            try file.read(into: buffer!)
            
            engine.attach(playerNode)
            let pitchEffect = AVAudioUnitTimePitch()
            pitchEffect.pitch = pitchEffectValue
            engine.attach(pitchEffect)
            
            let speedEffect = AVAudioUnitVarispeed()
            speedEffect.rate = speedEffectValue
            engine.attach(speedEffect)

//            engine.connect(playerNode, to: engine.mainMixerNode, format: format)
            engine.connect(playerNode, to: speedEffect, format: format)
            engine.connect(speedEffect, to: pitchEffect, format: format)
            engine.connect(pitchEffect, to: engine.mainMixerNode, format: format)
                    

            engine.prepare()
            try engine.start()
            
            playerNode.scheduleBuffer(buffer!) {
                print("Playback completed")
            }
            
            playerNode.play()
        } catch {
            print("Error playing audio file: \(error.localizedDescription)")
        }
    }
}
