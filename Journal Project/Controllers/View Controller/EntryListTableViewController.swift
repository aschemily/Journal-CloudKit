//
//  EntryListTableViewController.swift
//  Journal Project
//
//  Created by Emily Asch on 2/8/22.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    //MARK: Properties Segue
    var journal: Journal?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return journal?.entries.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        // Configure the cell...
        guard let journal = journal else {return cell}
        let entry = journal.entries[indexPath.row]
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.body

        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guard let journal = journal else {return}
            let entryToDelete = journal.entries[indexPath.row]
            EntryController.delete(entry: entryToDelete, journal: journal)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        //IIDOO
        guard let destination = segue.destination as? EntryDetailViewController else {return}
        //Identifier
        if segue.identifier == "toEntryDetailVC"{
            //index path
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
                  // destination
            
            //object to send
            let entryToSend = journal?.entries[indexPath.row]
            
            //object to receive
            destination.entry = entryToSend
        }
        destination.journal = journal
    }
    

}
