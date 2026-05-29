//
//  Flashcard.swift
//  FlashCardCohort8
//
//  Created by Kit Sitou on 5/28/26.
//
import Foundation

//equatable = can be compare to the other type
struct Flashcard:Identifiable, Codable, Equatable{
    
    let id: UUID
    var front: String
    var back: String
//    var desc: String
    
    
    init(id:UUID = UUID(), front: String, back: String) {
        self.id = id
        self.front = front
        self.back = back
    }
    
}
