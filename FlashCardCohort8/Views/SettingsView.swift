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
    
    @AppStorage("SETTING_THEME") private var theme: Theme = .system
    @AppStorage("SETTING_TITLE_SIZE") private var titleSize: TitleSize = SETTING_TITLE_SIZE_VALUE
    
    
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
                
                Picker("Theme", selection: $theme){
                    ForEach(Theme.allCases, id: \.self){
                        theme in
                        Text(theme.rawValue).tag(theme)
                    }
                }
                
                Picker("Deck Title Size", selection: $titleSize){
                    ForEach(TitleSize.allCases, id: \.self){
                        font in
                        Text(font.rawValue).tag(font)
                    }
                }
                
                
            }
        } //.navigationTitle(deck.name)
    }
}


#Preview {
    
    SettingsView()
}
