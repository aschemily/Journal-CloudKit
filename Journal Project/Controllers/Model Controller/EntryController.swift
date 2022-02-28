//
//  EntryController.swift
//  Journal Project
//
//  Created by Emily Asch on 2/8/22.
//

import Foundation

class EntryController {
  // static let shared = EntryController() -> no longer needed because source of truth isn't being used
    
    //var entries:[Entry] = [] -> no longer needed because saving entries to journal list
    
    //MARK: Entry CRUD
   static func createEntryWith(title: String, body: String, journal: Journal){
        let newEntry = Entry(title: title, body: body)
//        entries.append(newEntry) refactored
        journal.entries.append(newEntry)
       // saveToPersistentStorage() refactored
        JournalController.shared.saveToPersistentStorage()
    }
    
    static func updateEntry(title: String, body: String, entry: Entry){
        entry.title = title
        entry.body = body
        //save
        JournalController.shared.saveToPersistentStorage()
    }
    
 static func delete(entry: Entry, journal: Journal){
        //below is going to specific source of truth
        //guard let index = entries.firstIndex(of: entry) else{return}
        
        //specific entry in array in journal
        guard let index = journal.entries.firstIndex(of: entry) else {return}
        print("index to delete is", index)
        journal.entries.remove(at: index)
        
        JournalController.shared.saveToPersistentStorage()
    }
    
    
  
    
    
    
    
}// end of class
