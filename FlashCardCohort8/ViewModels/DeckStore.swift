//
//  DeckStore.swift
//  FlashCardCohort8
//
//  Created by Kit Sitou on 5/26/26.
//
import SwiftUI
import Foundation
import Combine

class DeckStore:ObservableObject {
    @Published var decks: [Deck] = []
        
    private var filestore = FileStore(fileName: " decks.json")
    
    var sampleDecks:[Deck] = [
        Deck(name: "Spanish", cards: [
            Flashcard(front: "Hello", back: "Hola")]),
        Deck(name: "Japanese", cards: [
            Flashcard(front: "Hello", back: "Ohayo"),
            Flashcard(front: "Thank you", back: "Domo Arigato")]),
        Deck(name: "Swift", cards: [
            Flashcard(front: "Let", back: "Constant variable"),
            Flashcard(front: "var", back: "mutable variable")])
        
    ]
    
    init(){
        load()
        if decks.isEmpty{
            decks = sampleDecks
        }
    }
    
    func addCard(to deckID:UUID, front: String, back:String){
        
        //if can create/ get decks.first index==deckID which is UUID type, then continue
        //meaning the decks exists,
        //add card to decks, a card contain the front and back
        guard let i = decks.firstIndex(where: {$0.id == deckID})else {return}
        decks[i].cards.append(Flashcard(front: front, back: back))
    }
    
    // deleteCard func look for deckID that is UUID type,
    // IndexSet, is the index item of the list view
    // at offsets: IndexSet, using the swipe ui to delete
    // atOffsets remove and rearrange the cards
    func deleteCard(in deckID:UUID, at offests: IndexSet){
        //if can create/ get decks.first index==deckID which is UUID type, then continue
        guard let i = decks.firstIndex(where: {$0.id == deckID})else {return}
        decks[i].cards.remove(atOffsets: offests)
    }
    
    
    //MARK: add-------
    func addDeck(name:String){
        //empty deck container
        let newDeck:Deck = Deck(name: name, cards: [])
        //go to append to the old decks
        decks.append(newDeck)
        
    }
    
    //MARK: search for deck using id-----
    func deck(for deckID:UUID)-> Deck?{
        decks.first(where:{$0.id == deckID})
    }
    
    //MARK: delete
    //index set has a delele button
    func deleteDeck(at offsets: IndexSet){
        decks.remove(atOffsets: offsets)
    }
    
    //MARK: LAOD-----
    private func load(){
        //use a do catch statement to catch any errors
        //load the Deck type file form filestore
        do{
            decks = try filestore.load([Deck].self)
        }catch{
            decks = []
            
        }
    }
    
    //MARK: SAVE
    private func save(){
        do{
            try filestore.save(decks)
        }catch{
            //display error from enum of 
            print("ERROR: SAVING DATA -> ", error.localizedDescription)
        }
    }
        
        /*
        Deck(name: "Spanish", cards: [
            Flashcard(front: "Hello", back: "Hola")]),
        Deck(name: "Japanese", cards: [
            Flashcard(front: "Hello", back: "Ohayo"),
            Flashcard(front: "Thank you", back: "Domo Arigato")]),
        Deck(name: "Swift", cards: [
            Flashcard(front: "Let", back: "Constant variable"),
            Flashcard(front: "var", back: "mutable variable")])*/
        
//    ]
}
