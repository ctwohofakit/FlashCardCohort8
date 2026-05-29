//
//  AddCardView.swift
//  FlashCardCohort8
//
//  Created by Kit Sitou on 5/28/26.
//

import SwiftUI

struct AddCardView: View {
    //dismiss action
    @Environment(\.dismiss) private var dismiss
    
    //create deckstore
    @EnvironmentObject var store: DeckStore
    @State var front: String = ""
    @State var back: String = ""
    
    
    let deckID: UUID //getting id from parent
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Front"){
                    TextField("Front/ Question", text: $front)
                }
                Section("Back"){
                    TextField("Back/ Answer", text: $back)
                }
            }
        
        .navigationTitle(Text("Add new card"))
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                Button("Cancel"){
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing){
                Button("Add"){
                    let f = front.trimmingCharacters(in: .whitespacesAndNewlines)
                    let b = back.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    //if a it is not empty, and b not empty, add
                    guard !f.isEmpty, !b.isEmpty else {
                        return
                    }
                    store.addCard(to: deckID, front: f, back: b)
                    dismiss()
                    
                }
                .disabled(front.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || back.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddCardView(deckID:UUID())
    }
 
}
