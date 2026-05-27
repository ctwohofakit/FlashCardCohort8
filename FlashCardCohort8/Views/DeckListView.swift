//
//  DeckListView.swift
//  FlashCardCohort8
//
//  Created by Kit Sitou on 5/26/26.
//

import SwiftUI

struct DeckListView: View {
    //since parrent has it, call it
    @EnvironmentObject var store: DeckStore
    @AppStorage("Hello") private var name: String = "Hello"
    
    var body: some View {
    
        List{
            Section("Decks"){
                ForEach(store.decks){deck in
                    NavigationLink{
                        //Detail view
                        StudyView(deck: deck)
                    } label:{
                        VStack(alignment: .leading){
                            Text(deck.name)
                                .font(.headline)
                            
                            Text("\(deck.cards.count) cards")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    
                }
            }
            
        }
        .navigationTitle("Flashcards")
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                NavigationLink{
                    
                    SettingsView()
                }label: {
                    Text("settings")
                    Image(systemName: "gear")
                        .foregroundStyle(.blue)
                }
            }
                
            }
    }
}


#Preview{
    NavigationStack{
        DeckListView().environmentObject(DeckStore())
    }
}
