//
//  DeckDetailView.swift
//  FlashCardCohort8
//
//  Created by Kit Sitou on 5/28/26.
//

import SwiftUI

struct DeckDetailView: View {
    @EnvironmentObject var store: DeckStore
    
    @State private var showingAddCard:Bool = false
    
    let deckID: UUID
    
//    let deck:[Deck]? = [Deck(name:"Spanish", cards: [Flashcard(front: "test", back: "testb")])]
    
    
    var body: some View {
        let deck = store.deck(for: deckID)
        
        List{
            if let deck{
                Section("Card"){
                    if deck.cards.isEmpty{
                        Text("no cards yet")
                    }else {
                        ForEach(deck.cards) { card in
                            VStack{
                                Text(card.front)
                                Text(card.back)
                            }
                            
                        }
                        .onDelete{ offsets in
                            store.deleteCard(in: deckID, at: offsets)
                    }
                }
            }
            Section{
                NavigationLink{
                    StudyView(deck: deck)
                }label: {
                    Label("Study this deck", systemImage: "play.circle.fill")
                }
            }
        }
        else {
            Text("Deck not found")
            }
        
        }
        .navigationTitle(deck?.name ?? "Deck")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAddCard = true
                } label: {
                    Image(systemName: "plus")
                }
                .disabled(deck == nil)
            }
        }
        .sheet(isPresented: $showingAddCard){
            AddCardView(deckID: deckID)
        }
    }

}


#Preview {
    NavigationStack{
        DeckDetailView(deckID: UUID())
    }
}
