//
//  ViewController.swift
//  CHub
//
//  Created by Hans Ravnaas on 11/21/16.
//  Copyright © 2016 Hans Ravnaas. All rights reserved.
//

import UIKit

class CHubViewController: UIViewController {

	@IBOutlet weak var findButton: UIButton!
	@IBOutlet weak var tableView: UITableView!
	
	var searchResults: [String] = []
	
	@IBAction func findButtonClicked(_ sender: UIButton)
	{
		searchResults = []
		for i in 0...2
		{
			searchResults.append(String(format: "Fake Result %d for '%@'", i, "test"))
		}
		tableView.reloadData()
		
		//let url = cHubURL()
		//print("URL: '\(url)'")
		//performWebServiceRequest(with: url)
		//print(response)
		
		let config = URLSessionConfiguration.default
		var headers: [AnyHashable : Any]? = [:]
		headers?["TOKEN"] = "xxxxxxxxxxxx"
		config.httpAdditionalHeaders = headers
		
		let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
		//let defaultSession = URLSession(configuration: config)
		
		var dataTask: URLSessionDataTask?
		//let url = NSURL(string: "https://apiservices.marcents.com/Merchant/LatestMerchantFeeds?token=xxxxxxxxx&merchantID=RuleAuto&FeedType=Product&FeedStatus=Closed")
		
		//let url = NSURL(string: "https://apiservices.marcents.com/Merchant/LatestMerchantFeeds?merchantID=RuleAuto&FeedType=Product&FeedStatus=Closed")
		
		let url = NSURL(string: "https://apiservices.marcents.com/Channel/ChannelFeeds?merchantID=RuleAuto&CurrentPage=1&PageSize=100&SortExpression=LastStepDatetime&token=xxxxxxxxxxxx")
		
		dataTask = defaultSession.dataTask(with: url! as URL)
		{
			data, response, error in
			if let error = error
			{
				print(error.localizedDescription)
			}
			else if let httpResponse = response as? HTTPURLResponse {
				if httpResponse.statusCode == 200
				{
					let datastring = String(data: data!, encoding: String.Encoding.utf8)
					print("Got data")
					print(datastring)
				}
				else
				{
					print("Something didn't work out so well: \(httpResponse.statusCode)")
					print("\(response)")
				}
			}
			else
			{
				print("not httpResponse")
			}
			
		}
		dataTask?.resume()
		
		
	}
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
	}

	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
	}
	
	func cHubURL() -> URL
	{
		let merchantID = "RuleAuto"
		let userToken = "xxxxxxxx"
		let operation = "LatestMerchantFeeds"
		
		let urlString = String(
			format: "https://apiservices.marcents.com/Merchant/%@?token=%@&merchantID=%@&FeedType=Product&FeedStatus=Closed",
			//format: "https://apiservices.marcents.com/Merchant/%@?token=%@&merchantID=%@",
				operation,
				userToken,
				merchantID
		)
		let url = URL(string: urlString)
		
		return url!
	}
	
	func performWebServiceRequest(with url: URL) -> Void
	{
		let session = URLSession.shared
		let dataTask = session.dataTask(
			with: url,
			completionHandler:
			{
				data, response, error in
				if let error = error
				{
					print("Failure! \(error)")
				} else {
					print("Repsonse: \(response!)")
					print("Data: \(data!)")
					let datastring = String(data: data!, encoding: String.Encoding.utf8)
					print(datastring)
					// Could use NSXMLParser and  have it parse data,
					/// which is really NSData.
				}
			}
		)
		dataTask.resume()
		
//		do
//		{
//			return try String(contentsOf: url, encoding: .utf8)
//		}
//		catch
//		{
//			print("Download Error: \(error)")
//			return nil
//		}
	}
	
//	func parse(xml data: Data) -> [String: Any]?
//	{
//		do {
//			let parsedXML =  try XMLSerialization.xmlObject(with: data, options: []) as? [String: Any]
//			return parsedXML
//		} catch {
//			print("XML Error: \(error)")
//			return nil
//		}
//	}

}

extension CHubViewController: UITableViewDataSource

{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return searchResults.count
	}

	func tableView(_ tableView: UITableView,
	               cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		
		let cellIdentifier = "SearchResultCell"
		var cell: UITableViewCell! = tableView.dequeueReusableCell( withIdentifier: cellIdentifier)
		if(cell === nil)
		{
			cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
		}
	
		cell.textLabel!.text = searchResults[indexPath.row]
		return cell
	}
}
extension CHubViewController: UITableViewDelegate
{
	
}





