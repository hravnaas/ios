//
//  ViewController.swift
//  Adding to the Beast List
//
//  Created by Hans Ravnaas on 11/4/16.
//  Copyright © 2016 Hans Ravnaas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var tasks = ["Exercise for 30 minutes", "Wireframe for some project", "Do laundry"]
    
    @IBOutlet weak var insertTaskField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func insertButtonPressed(_ sender: UIButton) {
        // TODO: Trim whitespace first
        if !(insertTaskField.text?.isEmpty)!
        {
            tasks.append(insertTaskField.text!)
            tableView.reloadData()
        }
    }
    
    // --------------------------------------------------------------------
    // START: Copied from UITableViewDataSource source to satisfy interface
    // --------------------------------------------------------------------
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tasks.count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")!
        
        // if the cell has a text label, set it to the model that is corresponding to the row in array
        cell.textLabel?.text = tasks[indexPath.row]
        
        // return cell so that Table View knows what to draw in each row
        return cell
    }
    
    // ------------------------------------------------------------------
    // END: Copied from UITableViewDataSource source to satisfy interface
    // ------------------------------------------------------------------
    
    
}


