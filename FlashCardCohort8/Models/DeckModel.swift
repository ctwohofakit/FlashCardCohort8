//
//  FlashcardModel.swift
//  FlashCardCohort8
//
//  Created by Kit Sitou on 5/26/26.
//

import Foundation

//model for decks
struct Deck: Identifiable, Codable, Equatable{
    
    let id:UUID
    var name: String
    var cards: Array<Flashcard>
    var description: String
    
    //set for default
    init(id:UUID = UUID(), name: String, cards: Array<Flashcard>, description: String = "This is a new deck") {
        self.id = id
        self.name = name
        self.cards = cards
        self.description = description
    }
    
}

//model for flashcards

