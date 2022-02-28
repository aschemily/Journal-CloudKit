//
//  JournalController.swift
//  Journal Project
//
//  Created by Emily Asch on 2/8/22.
//

import Foundation

class JournalController{
    //shared variable
  static let shared = JournalController()
    
    //MARK: Source of truth
    var journals:[Journal] = []
    
    
    //MARK: CRUD
    
    // Create
    func createJournalWith(title: String){
        let newJournalTitle = Journal(title: title)
        journals.append(newJournalTitle)
        //save
        saveToPersistentStorage()
    }
    
    //Delete
    func delete(journal: Journal){
        guard let index = journals.firstIndex(of: journal) else {return}
        journals.remove(at: index)
        //save
        saveToPersistentStorage()
    }
    
    //MARK: Data Persistance
    
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Journal.json")
        return documentsDirectoryURL
    }
    
    func saveToPersistentStorage(){
        do{
            let data = try JSONEncoder().encode(journals)
            try data.write(to:fileURL())
        }catch{
            print("error persisting is:", error)
            print("error localized description IS:", error.localizedDescription)
        }
    }
    
    func loadFromPersistentStorage(){
        do{
            let data = try Data(contentsOf: fileURL())
             journals = try JSONDecoder().decode([Journal].self, from: data)
            // fetchedEntries = entries
        }catch{
            print("error loading data from persistent store", error)
            print("localized description in decoder", error)
        }
    }
    
    
    
}// end of class
