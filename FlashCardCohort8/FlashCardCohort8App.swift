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
    
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                DeckListView()
            }.environmentObject(store) // using enviroment Object to pass the parameters
        }
    }
}
