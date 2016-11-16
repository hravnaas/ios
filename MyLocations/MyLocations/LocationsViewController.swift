import UIKit
import CoreData
import CoreLocation

class LocationsViewController: UITableViewController
{
	var managedObjectContext: NSManagedObjectContext!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		navigationItem.rightBarButtonItem = editButtonItem
		performFetch()
	}
	
	func performFetch()
	{
		do
		{
			try fetchedResultsController.performFetch()
		}
		catch
		{
			fatalCoreDataError(error)
		}
	}
	
	deinit
	{
		fetchedResultsController.delegate = nil
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		let sectionInfo = fetchedResultsController.sections![section]
		return sectionInfo.numberOfObjects
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
		let location = fetchedResultsController.object(at: indexPath)
		cell.configure(for: location)
		return cell
	}
	
	// Sections
	override func numberOfSections(in tableView: UITableView) -> Int
	{
		return fetchedResultsController.sections!.count
	}
	
	// Sections
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
	{
	  let sectionInfo = fetchedResultsController.sections![section]
	  return sectionInfo.name
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		if segue.identifier == "EditLocation"
		{
			let navigationController = segue.destination as! UINavigationController
			let controller = navigationController.topViewController as! LocationDetailsViewController
			controller.managedObjectContext = managedObjectContext
			
			if let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
			{
				let location = fetchedResultsController.object(at: indexPath)
				controller.locationToEdit = location
			}
		}
	}
	
	lazy var fetchedResultsController:
		NSFetchedResultsController<MyLocation> = {
			let fetchRequest = NSFetchRequest<MyLocation>()
			let entity = MyLocation.entity()
			fetchRequest.entity = entity
			
			let sortDescriptor1 = NSSortDescriptor(key: "category", ascending: true)
			let sortDescriptor2 = NSSortDescriptor(key: "date", ascending: true)
			fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
			
			fetchRequest.fetchBatchSize = 20
			let fetchedResultsController = NSFetchedResultsController(
				fetchRequest: fetchRequest,
				managedObjectContext: self.managedObjectContext,
				sectionNameKeyPath: "category",
				cacheName: "Locations"
			)
			fetchedResultsController.delegate = self
			return fetchedResultsController
	}()
}

/////////////////////////////////////////////////////
// Extension of NSFetchedResultsControllerDelegate //
/////////////////////////////////////////////////////

extension LocationsViewController: NSFetchedResultsControllerDelegate
{
	func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
	{
		print("*** controllerWillChangeContent")
		tableView.beginUpdates()
	}
	
	func controller(
		_ controller: NSFetchedResultsController<NSFetchRequestResult>,
		didChange anObject: Any,
		at indexPath: IndexPath?,
		for type: NSFetchedResultsChangeType,
		newIndexPath: IndexPath?)
	{
		switch type
		{
			case .insert:
				print("*** NSFetchedResultsChangeInsert (object)")
				tableView.insertRows(at: [newIndexPath!], with: .fade)
			case .delete:
				print("*** NSFetchedResultsChangeDelete (object)")
				tableView.deleteRows(at: [indexPath!], with: .fade)
			case .update:
				print("*** NSFetchedResultsChangeUpdate (object)")
				if let cell = tableView.cellForRow(at: indexPath!) as? LocationCell
				{
					let location = controller.object(at: indexPath!) as! MyLocation
					cell.configure(for: location)
				}
			case .move:
				print("*** NSFetchedResultsChangeMove (object)")
				tableView.deleteRows(at: [indexPath!], with: .fade)
				tableView.insertRows(at: [newIndexPath!], with: .fade)
		}
	}
	
	func controller(
		_ controller: NSFetchedResultsController<NSFetchRequestResult>,
		didChange sectionInfo: NSFetchedResultsSectionInfo,
		atSectionIndex sectionIndex: Int,
		for type: NSFetchedResultsChangeType)
	{
		switch type
		{
			case .insert:
				print("*** NSFetchedResultsChangeInsert (section)")
				tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
			case .delete:
				print("*** NSFetchedResultsChangeDelete (section)")
				tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
			case .update:
				print("*** NSFetchedResultsChangeUpdate (section)")
			case .move:
				print("*** NSFetchedResultsChangeMove (section)")
		}
	}
	
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
	{
		print("*** controllerDidChangeContent")
		tableView.endUpdates()
	}
	
	override func tableView(_ tableView: UITableView,
	                        commit editingStyle: UITableViewCellEditingStyle,
	                        forRowAt indexPath: IndexPath)
	{
		if editingStyle == .delete
		{
			let location = fetchedResultsController.object(at: indexPath)
			managedObjectContext.delete(location)
			do {
				try managedObjectContext.save()
			} catch {
				fatalCoreDataError(error)
			}
		}
	}
}