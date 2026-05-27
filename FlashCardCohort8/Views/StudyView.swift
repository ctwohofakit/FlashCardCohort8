//
//  StudyView.swift
//  FlashCardCohort8
//
//  Created by Kit Sitou on 5/26/26.
//

import SwiftUI

struct StudyView: View {
    let deck: Deck
    
    @AppStorage("shuffleCards") private var shuffleCards: Bool = true
    @AppStorage("showBackFirst") private var showBackFirst: Bool = false
    @AppStorage("cardsPerSession") private var cardsPerSession: Int = 10
    
    //dark theme
    
    
    //font size
    
    
    
    @State private var index: Int = 0
    @State private var isFlipped: Bool = false
    @State private var sessionCards: [Flashcard] = []
    
    
    var body: some View {
    
        VStack(spacing:20){
                if sessionCards.isEmpty{
                Text("No card inside this deck")
                        .foregroundStyle(.secondary)
                    
                }else {
                    Text("\(index + 1) / \(sessionCards.count)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    ZStack{
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.thinMaterial)
                            .frame(height: 220)
                        Text(currentText)
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .padding()
                            
                    }.onTapGesture {
                        isFlipped.toggle()
                    }
                    HStack(spacing: 16){
                        Button("<"){
                            prev()
                        }
                        .disabled(index == 0)
                        .buttonStyle(.borderedProminent)
                        .font(.largeTitle)
                        
                        Button("Flip card"){
                            isFlipped.toggle()
                        }.buttonStyle(.borderedProminent)
                            .font(.largeTitle)
                        Button(">"){
                            next()
                        }
                        .disabled(index == sessionCards.count - 1)
                        .buttonStyle(.borderedProminent)
                        .font(.largeTitle)
                        
                    }
                    
                }
        }
        .navigationTitle(deck.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            startSession()
        }
        
    }//end of body
    //computed variable
    private var currentText:String {
        
        guard !sessionCards.isEmpty else {return ""}
        
        let card = sessionCards[index]
        
        let showingFront = showBackFirst ? !isFlipped : !isFlipped
        return showingFront ? card.front: card.back
    }
    
    private func startSession(){
        var cards = deck.cards
        //shuffle 100
        if shuffleCards {
            cards.shuffle()
        }
                        //10             100
        let limit = min(cardsPerSession, cards.count)
        
        //add cards into a session
        sessionCards = Array(cards.prefix(limit))
        
        index = 0
        isFlipped = false
        
    }
    
    private func next(){
        // if index = 0 < 10, it will not go to next index
        if index < sessionCards.count - 1 {
            index += 1
            isFlipped = false
        }
    }
    
    
    private func prev(){
        //  2 > 0
        // 0 > 0 , no card behind, it is the end
        
        if index > 0 {
            index -= 1
            isFlipped = false
        }
    }
    
    
    
}

#Preview {
    NavigationStack{
        StudyView(deck: Deck(name: "Spanish", cards: [Flashcard(front: "Hello",back: "Hola"),Flashcard(front: "Goodbye",back: "Adiós")]))
    }
}
