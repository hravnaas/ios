//
//  AddUser+CoreDataProperties.swift
//  Basic Crud
//
//  Created by Hans Ravnaas on 11/8/16.
//  Copyright © 2016 Hans Ravnaas. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension AddUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AddUser> {
        return NSFetchRequest<AddUser>(entityName: "AddUser");
    }

    @NSManaged public var email: NSObject?
    @NSManaged public var password: NSObject?
    @NSManaged public var username: NSObject?

}
