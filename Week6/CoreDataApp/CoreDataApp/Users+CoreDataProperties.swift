//
//  Users+CoreDataProperties.swift
//  CoreDataApp
//
//  Created by Nguyen Thanh Duc on 11/1/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users");
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?

}
