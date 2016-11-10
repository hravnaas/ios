//
//  ViewController.swift
//  Checklists
//
//  Created by Hans Ravnaas on 11/9/16.
//  Copyright © 2016 Hans Ravnaas. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate
{
	var items: [ChecklistItem]
	
	required init?(coder aDecoder: NSCoder)
	{
		items = [ChecklistItem]()
	  let row0item = ChecklistItem()
	  row0item.text = "Walk the dog"
	  row0item.checked = false
	  items.append(row0item)
	  let row1item = ChecklistItem()
	  row1item.text = "Brush my teeth"
	  row1item.checked = true
	  items.append(row1item)
	  let row2item = ChecklistItem()
	  row2item.text = "Learn iOS development"
	  row2item.checked = true
	  items.append(row2item)
	  let row3item = ChecklistItem()
	  row3item.text = "Soccer practice"
	  row3item.checked = false
	  items.append(row3item)
	  let row4item = ChecklistItem()
	  row4item.text = "Eat ice cream"
	  row4item.checked = true
	  items.append(row4item)
	  super.init(coder: aDecoder)
	}
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
	}

	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return items.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
		let item = items[indexPath.row]
		configureText(for: cell, with: item)
		configureCheckmark(for: cell, with: item)
		return cell
		
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		if let cell = tableView.cellForRow(at: indexPath)
		{
			let item = items[indexPath.row]
			item.toggleChecked()
			configureCheckmark(for: cell, with: item)
		}
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	override func tableView(_ tableView: UITableView,
	                        commit editingStyle: UITableViewCellEditingStyle,
	                        forRowAt indexPath: IndexPath)
	{
		// 1
		items.remove(at: indexPath.row)
		// 2
		let indexPaths = [indexPath]
		tableView.deleteRows(at: indexPaths, with: .automatic)
	}
	
	func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem)
	{
		let label = cell.viewWithTag(1001) as! UILabel
		if item.checked
		{
			label.text = "√"
		}
		else
		{
			label.text = ""
		}
	}
	
	func configureText(for cell: UITableViewCell, with item: ChecklistItem)
	{
		let label = cell.viewWithTag(1000) as! UILabel
		label.text = item.text
	}
	
	func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
	{
		dismiss(animated: true, completion: nil)
	}
	
	func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem)
	{
		let newRowIndex = items.count
		items.append(item)
		let indexPath = IndexPath(row: newRowIndex, section: 0)
		let indexPaths = [indexPath]
		tableView.insertRows(at: indexPaths, with: .automatic)
		dismiss(animated: true, completion: nil)
	}
	
	func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem)
	{
		if let index = items.index(of: item)
		{
			let indexPath = IndexPath(row: index, section: 0)
			if let cell = tableView.cellForRow(at: indexPath)
			{
				configureText(for: cell, with: item)
			}
		}
		dismiss(animated: true, completion: nil)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		// 1
		if segue.identifier == "AddItem"
		{
			// 2
			let navigationController = segue.destination as! UINavigationController
			// 3
			let controller = navigationController.topViewController as! ItemDetailViewController
			// 4
			controller.delegate = self
		}
		else if segue.identifier == "EditItem"
		{
			let navigationController = segue.destination as! UINavigationController
			let controller = navigationController.topViewController as! ItemDetailViewController
			controller.delegate = self
			
			if let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
			{
				controller.itemToEdit = items[indexPath.row]
			}
		}
	}
}

