//
//  FlashCardCohort8App.swift
//  FlashCardCohort8
//
//  Created by Kit Sitou on 5/26/26.
//

import SwiftUI

@main
struct FlashCardCohort8App: App {
    @StateObject private var store = DeckStore()
    @AppStorage("SETTING_THEME") private var theme: Theme = .system
    
    var colorScheme: ColorScheme? {
        switch(theme){
        case .light: return .light
        case .dark: return .dark
        case .system: return nil
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                DeckListView()
            }.environmentObject(store)
                .preferredColorScheme(colorScheme)
            // using enviroment Object to pass the parameters
        }
    }
}
