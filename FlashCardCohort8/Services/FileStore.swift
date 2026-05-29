//
//  FilteStore.swift
//  FlashCardCohort8
//
//  Created by Kit Sitou on 5/28/26.
//

import Foundation

//Enums are great for errors or options
enum FilterStoreError: Error {
    case invalidDocumentDirectory
}

struct FileStore{
    //Filename of our JSON
    private var fileName:String
    
    // decide the file name of the jason file
    init(fileName: String = "deck.json"){
        self.fileName = fileName
    }
    
    
    //MARK: FileManager -> Get file directory URL to save or load file
    
    //ERRORS, URL
    private func fileURL() throws ->URL {
        //if can't create a file with the file name, throw error "invalidDocumentDirctory"
        guard let doc = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{
            throw FilterStoreError.invalidDocumentDirectory
        }
        //  /Documents/flashcardmedia/[filename]
        // this function return /Documents/flashcardmedia/decks.json
        
        return doc.appendingPathExtension(fileName)
    }
    
    //function load, decode
    // <> = Generic type, <T:Decodable> = any tupe that can be Decodable
    // (_ type: T.Type) = I am expexting a positional argument of the type that you are sending
    // load(type: BOJECT) = load(OBJECT)
    // throws -> T = this functin can throw errprs and im expecting back data that is the same type of data
    
    //load(flashcards) -> flashcards
    //load(decks) -> decks
    //load(cards) -> cards
    
    // it is load a blanket type to call it to return a certain type
    func load<T:Decodable>(_ type: T.Type) throws -> T{
        
        //try to Get the url/path of my data(in this case is a JSON file)
        let url = try fileURL()
        
        //try to store the data from that url into a variable, at this point my file is of type Data
        let data = try Data(contentsOf: url)
        
        // if we are ab;e to go from JSON to a SwiftModel return it here
        return try JSONDecoder().decode(T.self, from: data)
        

    }
    
    //SAVE go from model to JSON use value
    func save<T:Encodable>(_ value: T) throws{
        let url = try fileURL()
        
        //at this point the data is a model
        //here it gets parsed in to bytes to save
        let data = try JSONEncoder().encode(value)
        
        //data.write to save the information inside our URL, use atmic method to create temporary copy
        //temporary copy is the backup
        try data.write(to: url, options: .atomic)
    }
    
    // Delete
    func deleteFile() throws{
        let url = try fileURL()
        //if the file path exist
        if FileManager.default.fileExists(atPath: url.path){
            //try to delete it 
            try FileManager.default.removeItem(at: url)
        }
    }
    
    
    
    
    
    
    
    
    
    
}
