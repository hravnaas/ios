//
//  MyLocation+CoreDataClass.swift
//  MyLocations
//
//  Created by Hans Ravnaas on 11/15/16.
//  Copyright © 2016 Hans Ravnaas. All rights reserved.
//

import Foundation
import CoreData
import MapKit

@objc(MyLocation)

public class MyLocation: NSManagedObject, MKAnnotation
{
	public var coordinate: CLLocationCoordinate2D
	{
		return CLLocationCoordinate2DMake(latitude, longitude)
	}
	
	public var title: String?
	{
		if locationDescription.isEmpty
		{
			return "(No Description)"
		}
		else
		{
			return locationDescription
		}
	}
	
	public var subtitle: String?
	{
		return category
	}
}
