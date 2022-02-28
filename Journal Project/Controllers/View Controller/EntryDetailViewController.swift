//
//  EntryDetailViewController.swift
//  Journal Project
//
//  Created by Emily Asch on 2/8/22.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    var entry: Entry?
    var journal: Journal?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateViews()
    }
    
    func updateViews(){
        
        guard let entry = entry else {return}
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
    

    @IBAction func clearTextButtonPressed(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        print("in save button action")
        guard let journal = journal,
            let title = titleTextField.text, !title.isEmpty,
            let body = bodyTextView.text, !body.isEmpty
       else {return print("inside else guard")}
        
        if let entry = entry{
            print("updating entry")
            EntryController.updateEntry(title: title, body: body, entry: entry)
        }else{
            print("should create entry?")
            EntryController.createEntryWith(title: title, body: body, journal: journal)
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    
} // End of class
