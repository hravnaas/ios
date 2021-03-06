//
//  ViewController.swift
//  HitList
//
//  Created by Hans Ravnaas on 11/7/16.
//  Copyright © 2016 Hans Ravnaas. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "The List"
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")
    }

    @IBOutlet weak var tableView: UITableView!
    var people: [NSManagedObject] = []
    
    @IBAction func addName(_ sender: UIBarButtonItem)
    {
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default)
        {
            [unowned self] action in guard let textField = alert.textFields?.first,
            let nameToSave = textField.text
            else
            {
                return
            }
                                        
        self.names.append(nameToSave)
        self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                        style: .default)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        return people.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
            
            let person = people[indexPath.row]
            let cell =
                tableView.dequeueReusableCell(withIdentifier: "Cell",
                                              for: indexPath)
            cell.textLabel?.text =
                person.value(forKeyPath: "name") as? String
            return cell
    }
}



