//
//  DeckStore.swift
//  FlashCardCohort8
//
//  Created by Kit Sitou on 5/26/26.
//

import Foundation
import Combine

class DeckStore:ObservableObject {
    @Published var decks: [Deck] = [
        Deck(name: "Spanish", cards: [
            Flashcard(front: "Hello", back: "Hola")]),
        Deck(name: "Japanese", cards: [
            Flashcard(front: "Hello", back: "Ohayo"),
            Flashcard(front: "Thank you", back: "Domo Arigato")]),
        Deck(name: "Swift", cards: [
            Flashcard(front: "Let", back: "Constant variable"),
            Flashcard(front: "var", back: "mutable variable")])
        
    ]
}
