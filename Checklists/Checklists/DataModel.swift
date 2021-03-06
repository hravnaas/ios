import Foundation
class DataModel
{
	var lists = [Checklist]()
	
	init()
	{
		loadChecklists()
		registerDefaults()
		handleFirstTime()	
	}
	
	func documentsDirectory() -> URL
	{
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
	
	func dataFilePath() -> URL
	{
		return documentsDirectory().appendingPathComponent("Checklists.plist")
	}
	
	func saveChecklists()
	{
		let data = NSMutableData()
		let archiver = NSKeyedArchiver(forWritingWith: data)
		archiver.encode(lists, forKey: "Checklists")
		archiver.finishEncoding()
		data.write(to: dataFilePath(), atomically: true)
	}
	
	func loadChecklists()
	{
		let path = dataFilePath()
		if let data = try? Data(contentsOf: path)
		{
			let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
			lists = unarchiver.decodeObject(forKey: "Checklists") as! [Checklist]
			unarchiver.finishDecoding()
		}
		sortChecklists()
	}
	
	func registerDefaults()
	{
		let dictionary: [String: Any] = [ "ChecklistIndex": -1, "FirstTime": true, "ChecklistItemID": 0 ]
		UserDefaults.standard.register(defaults: dictionary)
	}
	
	var indexOfSelectedChecklist: Int
	{
		get
		{
			//let index = UserDefaults.standard.integer(forKey: "ChecklistIndex")
			//return (index + 1) > lists.count ? -1 : index
			return UserDefaults.standard.integer(forKey: "ChecklistIndex")
		}
		set
		{
			UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
			// force immediate save to disk
			// UserDefaults.standard.synchronize()
		}
	}
	
	func handleFirstTime()
	{
		let userDefaults = UserDefaults.standard
		let firstTime = userDefaults.bool(forKey: "FirstTime")
		if firstTime
		{
			let checklist = Checklist(name: "List")
			lists.append(checklist)
			indexOfSelectedChecklist = 0
			userDefaults.set(false, forKey: "FirstTime")
			userDefaults.synchronize()
		}
	}
	
	func sortChecklists()
	{
		lists.sort(
			by:
			{
				checklist1, checklist2 in return checklist1.name.localizedStandardCompare(checklist2.name) == .orderedAscending
			}
		)
	}
	
	// Using class keyword here to make it "static".
	class func nextChecklistItemID() -> Int
	{
		let userDefaults = UserDefaults.standard
		let itemID = userDefaults.integer(forKey: "ChecklistItemID")
		userDefaults.set(itemID + 1, forKey: "ChecklistItemID")
		userDefaults.synchronize()
		return itemID
	}

}
