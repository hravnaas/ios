//
//  MissionDetailsViewControllerDelegate.swift
//  Bucket List
//
//  Created by Hans Ravnaas on 11/6/16.
//  Copyright © 2016 Hans Ravnaas. All rights reserved.
//
import Foundation

protocol MissionDetailsViewControllerDelegate: class
{
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishAddingMission mission: String)
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishEditingMission mission: String, atIndexPath indexPath: Int)

}
