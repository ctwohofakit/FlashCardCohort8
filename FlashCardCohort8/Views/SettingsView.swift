//
//  SettingsView.swift
//  FlashCardCohort8
//
//  Created by Kit Sitou on 5/26/26.
//

import SwiftUI

struct SettingsView: View {
    // pass the key = value
    @AppStorage("shuffleCards") private var shuffleCards: Bool = true
    
    @AppStorage("showBackFirst") private var showBackFirst: Bool = false
    @AppStorage("cardsPerSession") private var cardsPerSession: Int = 10
    
    var body: some View {
        Form{
            Section("Study"){
                Toggle("Shuffle cards", isOn: $shuffleCards)
                Toggle("Show back first", isOn: $showBackFirst)
                Stepper("Cards per session: \(cardsPerSession)", value: $cardsPerSession,
                    in: 1...30)
            }
            
            Section("About"){
                Text("This Settings are being persisted using UserDefaults")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        } //.navigationTitle(deck.name)
    }
}


#Preview {
    
    SettingsView()
}
