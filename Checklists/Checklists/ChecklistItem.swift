//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Hans Ravnaas on 11/9/16.
//  Copyright © 2016 Hans Ravnaas. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject
{
	var text = ""
	var checked = false
	
	func toggleChecked()
	{
		self.checked = !self.checked
	}
}
