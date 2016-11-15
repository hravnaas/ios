//
//  MyLocation+CoreDataProperties.swift
//  MyLocations
//
//  Created by Hans Ravnaas on 11/15/16.
//  Copyright © 2016 Hans Ravnaas. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation

extension MyLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyLocation> {
        return NSFetchRequest<MyLocation>(entityName: "MyLocation");
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var date: Date
    @NSManaged public var locationDescription: String
    @NSManaged public var category: String
    @NSManaged public var placemark: CLPlacemark?

}
