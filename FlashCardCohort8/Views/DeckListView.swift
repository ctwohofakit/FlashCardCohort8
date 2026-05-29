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
    
    @State private var showingAddDeck = false
    
    
    //font size
    @AppStorage("SETTING_TITLE_SIZE") private var titleSize: TitleSize = SETTING_TITLE_SIZE_VALUE
    @AppStorage("SETTING_THEME") private var theme: Theme = .system
    
    var deckNameFont: Font{
        switch(titleSize){
        case .small: return .headline
        case .medium: return .title2
        case .big: return .title
        }
    }
    
    @State private var hue:Double = 0
    
    var body: some View {
        VStack{
            ZStack{
                Color(.blue.opacity(0.5))
                    .ignoresSafeArea(edges: .all)
                HStack{
                    Image(systemName: "sun.max.fill")
                        .font(.system(size: 25))
                        .foregroundStyle(.yellow)
                        .hueRotation(Angle(degrees: hue))
                        .onAppear{
                            withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)){hue = 360}
                        }
                    
                        .foregroundStyle(.yellow)
                    Text("Have you been studying today?")
                        .foregroundStyle(.white)
                        .font(.system(size: 20))
                        .bold()
                    
                }
                
                
                
            }
            .frame(maxHeight: 160)
            .preferredColorScheme(.light)
        }
        VStack{
            List{
                Section("Decks"){
                    ForEach(store.decks){deck in
                        NavigationLink{
                            //Detail view
                            DeckDetailView(deckID: deck.id)
                        } label:{
                            VStack(alignment: .leading){
                                Text(deck.name)
                                    .font(deckNameFont)
                                    .multilineTextAlignment(.leading)
                                
                                Text("\(deck.cards.count) cards")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        
                        
                    }
                    .onDelete(perform: store.deleteDeck)
                }
                
            }
        }
            .navigationTitle("Flashcards")
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                   
                        EditButton()
                    }
                ToolbarItem(placement: .topBarTrailing) {
                          Button { showingAddDeck = true } label: {
                              Image(systemName: "plus")
                          }
                      }
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
            .sheet(isPresented: $showingAddDeck){
                AddDeckView()
            }
    }
}


#Preview{
    NavigationStack{
        DeckListView().environmentObject(DeckStore())
    }
}
