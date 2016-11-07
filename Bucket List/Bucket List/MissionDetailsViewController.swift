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
    @IBAction func cancelBarButtonPressed(_ sender: UIBarButtonItem)
    {
        cancelButtonDelegate?.cancelButtonPressedFrom(controller: self)
    }
    
    @IBAction func doneBarButtonPressed(_ sender: UIBarButtonItem)
    {
        delegate?.missionDetailsViewController(controller: self, didFinishAddingMission: newMissionTextField.text!)
    }
    
    weak var delegate: MissionDetailsViewControllerDelegate?
    weak var cancelButtonDelegate: CancelButtonDelegate?
}

// reason: '-[Bucket_List.MissionDetailsViewController cancelBarButtonPressed:]: unrecognized selector sent to instance 0x7fc268e1ca40'
