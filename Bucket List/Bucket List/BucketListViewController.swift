//
//  ViewController.swift
//  Bucket List
//
//  Created by Hans Ravnaas on 11/5/16.
//  Copyright © 2016 Hans Ravnaas. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController, CancelButtonDelegate, MissionDetailsViewControllerDelegate
{
    var missions = ["Sky diving", "Live in Hawaii"]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")!
        // All UITableViewCell objects have a build in textLabel so set it to the model that is corresponding to the row in array
        cell.textLabel?.text = missions[indexPath.row]
        // return cell so that Table View knows what to draw in each row
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return missions.count
    }
    
    func cancelButtonPressedFrom(controller: UIViewController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "AddNewMission"
        {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! MissionDetailsViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
        }
    }
    
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishAddingMission mission: String)
    {
        dismiss(animated: true, completion: nil)
        missions.append(mission)
        tableView.reloadData()
    }
}

