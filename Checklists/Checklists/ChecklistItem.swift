//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Hans Ravnaas on 11/9/16.
//  Copyright © 2016 Hans Ravnaas. All rights reserved.
//

import Foundation
import UserNotifications

class ChecklistItem: NSObject, NSCoding
{
	var text = ""
	var checked = false
	var dueDate = Date()
	var shouldRemind = false
	var itemID: Int
	
	func toggleChecked()
	{
		self.checked = !self.checked
	}
	
	func encode(with aCoder: NSCoder)
	{
		aCoder.encode(text, forKey: "Text")
		aCoder.encode(checked, forKey: "Checked")
		aCoder.encode(dueDate, forKey: "DueDate")
		aCoder.encode(shouldRemind, forKey: "ShouldRemind")
		aCoder.encode(itemID, forKey: "ItemID")
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		text = aDecoder.decodeObject(forKey: "Text") as! String
		checked = aDecoder.decodeBool(forKey: "Checked")
		dueDate = aDecoder.decodeObject(forKey: "DueDate") as! Date
		shouldRemind = aDecoder.decodeBool(forKey: "ShouldRemind")
		itemID = aDecoder.decodeInteger(forKey: "ItemID")
		super.init()
	}
	
	override init()
	{
		itemID = DataModel.nextChecklistItemID()
		super.init()
	}
	
	init(text: String, checked: Bool = false)
	{
		self.text = text
		self.checked = checked
		itemID = DataModel.nextChecklistItemID()
	}
	
	func scheduleNotification()
	{
		// Bruce force. Start by removing existing notitication to keep things simple.
		removeNotification()
		
		if shouldRemind && dueDate > Date()
		{
			let content = UNMutableNotificationContent()
			content.title = "Reminder:"
			content.body = text
			content.sound = UNNotificationSound.default()
			
			let calendar = Calendar(identifier: .gregorian)
			let components = calendar.dateComponents([.month, .day, .hour, .minute], from: dueDate)
			let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
			let request = UNNotificationRequest(identifier: "\(itemID)", content: content, trigger: trigger)
			let center = UNUserNotificationCenter.current()
			
			center.add(request)
			print("Scheduled notification \(request) for itemID \(itemID)")
		}
	}
	
	func removeNotification()
	{
		let center = UNUserNotificationCenter.current()
		center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
	}
	
	// Called when an object is about to get deleted.
	deinit
	{
		removeNotification()
	}
}
