//
//  ContactTableViewController.swift
//  MyFirstSwiftApp
//
//  Created by Steven Galvin on 9/12/17.
//  Copyright © 2017 Steven Galvin. All rights reserved.
//

import UIKit

class ContactTableViewController: UITableViewController {
    
    var contacts = [Contact]()
    
    func saveContacts() {
        let isSaved = NSKeyedArchiver.archiveRootObject(contacts, toFile: Contact.ArchiveURL.path)
        if !isSaved {
            print("Failed to save contacts...")
        }
    }
    
    func loadContacts() -> [Contact]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Contact.ArchiveURL.path) as? [Contact]
    }
    
    @IBAction func unwindToList(sender: UIStoryboardSegue){
        let srcViewCon = sender.source as? ViewController
        print("Look here 2")
        let contact = srcViewCon?.contact
        if (srcViewCon != nil && contact?.name != "" && contact?.number != ""){
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update contact
                contacts[selectedIndexPath.row] = contact!
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Add new contact
                let newIndexPath = NSIndexPath(row: contacts.count, section: 0)
                contacts.append(contact!)
                tableView.insertRows(at: [newIndexPath as IndexPath], with: UITableViewRowAnimation.bottom)
            }
            saveContacts()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let detailVC = segue.destination as? ViewController
            
            // Get the cell that generated this segue.
            if let selectedCell = sender as? ContactTableViewCell {
                let indexPath = tableView.indexPath(for: selectedCell)!
                let selectedContact = contacts[indexPath.row]
                detailVC?.contact = selectedContact
            }
        }
        else if segue.identifier == "AddContact" {
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedContacts = loadContacts() {
            contacts += savedContacts
        }
    

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ContactTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ContactTableViewCell

        let contact = contacts[indexPath.row]
        
        cell.nameLabel.text = contact.name
        cell.numberLabel.text = contact.number

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            contacts.remove(at: indexPath.row)
            saveContacts()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
