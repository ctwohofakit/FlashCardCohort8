//
//  AddDeckView.swift
//  FlashCardCohort8
//
//  Created by Kit Sitou on 5/28/26.
//

import SwiftUI

struct AddDeckView: View {
    @State var name: String = ""
    @EnvironmentObject var store: DeckStore
    //This control the position of the view top to bottom
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        NavigationStack{
            Form{
                TextField("Deck name", text: $name)
            }
            .navigationTitle("New Deck")
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button("save"){
                        
                        //make sure no white space in our input
                        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        //if input it is empty, break out of the function, and don't do anything
                        guard !trimmed.isEmpty else { return }
                        store.addDeck(name: trimmed)
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                
                
                
                
            }//end: tool bar
        }
    }
}


#Preview {
    AddDeckView()
}
