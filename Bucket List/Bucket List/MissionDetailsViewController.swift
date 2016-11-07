//
//  MissionDetailsViewController.swift
//  Bucket List
//
//  Created by Hans Ravnaas on 11/6/16.
//  Copyright © 2016 Hans Ravnaas. All rights reserved.
//

import UIKit

class MissionDetailsViewController: UITableViewController
{
    // cancelBarButton may not be needed. Added while trouble-shooting
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var newMissionTextField: UITextField!
    
    var missionToEdit: String?
    var missionToEditIndexPath: Int?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // TODO: Avoid warning below
        if var mission = missionToEdit
        {
            newMissionTextField.text = missionToEdit!
        }
    }
    
    @IBAction func cancelBarButtonPressed(_ sender: UIBarButtonItem)
    {
        cancelButtonDelegate?.cancelButtonPressedFrom(controller: self)
    }
    
    @IBAction func doneBarButtonPressed(_ sender: UIBarButtonItem)
    {
        // if we are editing then run the "didFinishEditingMission" method
        if var mission = missionToEdit
        {
            mission = newMissionTextField.text!
            delegate?.missionDetailsViewController(controller: self, didFinishEditingMission: mission, atIndexPath: missionToEditIndexPath!)
        }
        else
        { // we are adding so run the "didFinishAddingMission" method
            let mission = newMissionTextField.text!
            delegate?.missionDetailsViewController(controller: self, didFinishAddingMission: mission)
        }
    }
    
    weak var delegate: MissionDetailsViewControllerDelegate?
    weak var cancelButtonDelegate: CancelButtonDelegate?
}

// OLD VERSION - WORKS
//class MissionDetailsViewController: UITableViewController
//{
//    // cancelBarButton may not be needed. Added while trouble-shooting
//    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
//    @IBOutlet weak var newMissionTextField: UITextField!
//    
//    var missionToEdit: String?
//    var missionToEditIndexPath: Int?
//    
//    @IBAction func cancelBarButtonPressed(_ sender: UIBarButtonItem)
//    {
//        cancelButtonDelegate?.cancelButtonPressedFrom(controller: self)
//    }
//    
//    @IBAction func doneBarButtonPressed(_ sender: UIBarButtonItem)
//    {
//        delegate?.missionDetailsViewController(controller: self, didFinishAddingMission: newMissionTextField.text!)
//    }
//    
//    weak var delegate: MissionDetailsViewControllerDelegate?
//    weak var cancelButtonDelegate: CancelButtonDelegate?
//}
