//
//  AddingHapticEffects.swift
//  Porject10CupcakeCorner
//
//  Created by Aryan Panwar on 18/06/24.
//

import SwiftUI
import CoreHaptics
struct AddingHapticEffects: View {
    @State private var counter = 0
    @State private var engine : CHHapticEngine?
    var body: some View {
//        Button("Tap Count : \(counter)"){
//            counter += 1
//        }
//        .sensoryFeedback(.increase, trigger: counter)
//        .sensoryFeedback(.impact(flexibility: .soft , intensity: 0.5), trigger: counter)
//        .sensoryFeedback(.impact(weight: .heavy , intensity: 1), trigger: counter)
        
        Button("tap me", action: complexSuccess)
            .onAppear(perform: {
                prepareHaptics()
            })
    }
    
    func prepareHaptics(){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine : \(error.localizedDescription)")
        }
    }
    
    func complexSuccess(){
//        make sure the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        var events = [CHHapticEvent]()
        
//        create one intensity , sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity , sharpness], relativeTime: 0)
        events.append(event)
        
//        convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern : \(error.localizedDescription).")
        }
    }
}

#Preview {
    AddingHapticEffects()
}
