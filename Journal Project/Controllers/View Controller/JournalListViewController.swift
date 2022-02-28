//
//  JournalListViewController.swift
//  Journal Project
//
//  Created by Emily Asch on 2/8/22.
//

import UIKit

class JournalListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var journalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        journalTableView.delegate = self
        journalTableView.dataSource = self
        JournalController.shared.loadFromPersistentStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        journalTableView.reloadData()
    }
    

    @IBAction func createJournalTitlePressed(_ sender: Any) {
        guard let journalTitle = journalTitleTextField.text,
              !journalTitle.isEmpty else {return}
        
        JournalController.shared.createJournalWith(title: journalTitle)
        journalTableView.reloadData()
        journalTitleTextField.text = ""
    }
    
    //MARK: tableview data source functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalController.shared.journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = journalTableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        
        let journal = JournalController.shared.journals[indexPath.row]
        cell.textLabel?.text = journal.title
        cell.detailTextLabel?.text = "\(journal.entries.count) Entries"
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        //If
        if segue.identifier == "toEntryList"{
            //indexPath has both section and row number (only have 1 section atm)
            guard let indexPath = journalTableView.indexPathForSelectedRow,
                  //destination
                  let destination = segue.destination as? EntryListTableViewController
            else {return}
            //object to send
            let journal = JournalController.shared.journals[indexPath.row]
            
            //object to receive
            destination.journal = journal
        }
    }


}//end of class
