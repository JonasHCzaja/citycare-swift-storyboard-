//
//  OccurrencesTableViewController.swift
//  CityCare
//
//  Created by Jonas Czaja on 02/09/24.
//

import UIKit
import CoreData

class OccurrencesTableViewController: UITableViewController {
    
    var fetchedResultController: NSFetchedResultsController<Occurrence>!
    
    var occurrences: [Occurrence] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        loadOccurrences()
    }
    
    
    func loadOccurrences() {
        
        let fetchRequest: NSFetchRequest<Occurrence> = Occurrence.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "oc_category", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultController.delegate = self
        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.fetchedObjects?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OccurrenceTableViewCell

        /*
        // Usamos a propriedade row do IndexPath para recuperar o indice da celula, que e o mesmo indice do movie no array
        let movie = movies[indexPath.row]
        */
        
        
        
        let occurrence = fetchedResultController.object(at: indexPath)
        
        
        
        cell.lbIssue.text = occurrence.oc_category
        cell.lbDescription.text = occurrence.oc_description
        cell.lbStatus.text = occurrence.oc_status
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewController {
            let occurrence = fetchedResultController.object(at: tableView.indexPathForSelectedRow!)
            
            vc.occurrence = occurrence
        }
    }
    

}

extension OccurrencesTableViewController:NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller:NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let occurrence = fetchedResultController.object(at: indexPath)
            context.delete(occurrence)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        } else if editingStyle == .insert {
            
        }
    }
}
