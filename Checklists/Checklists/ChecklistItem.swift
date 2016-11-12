//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Hans Ravnaas on 11/9/16.
//  Copyright © 2016 Hans Ravnaas. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding
{
	var text = ""
	var checked = false
	
	func toggleChecked()
	{
		self.checked = !self.checked
	}
	
	func encode(with aCoder: NSCoder)
	{
		aCoder.encode(text, forKey: "Text")
		aCoder.encode(checked, forKey: "Checked")
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		text = aDecoder.decodeObject(forKey: "Text") as! String
		checked = aDecoder.decodeBool(forKey: "Checked")
		super.init()
	}
	
	override init()
	{
		super.init()
	}
	
	init(text: String, checked: Bool = false)
	{
		self.text = text
		self.checked = checked
	}
}
