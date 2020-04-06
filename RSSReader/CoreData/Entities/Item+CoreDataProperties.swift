//
//  Item+CoreDataProperties.swift
//  
//
//  Created by Dmitry Pasnenkov on 4/5/20.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var autor: String?
    @NSManaged public var categories: String?
    @NSManaged public var content: String?
    @NSManaged public var descr: String?
    @NSManaged public var image: Data?
    @NSManaged public var link: String?
    @NSManaged public var pubDate: Date?
    @NSManaged public var title: String?
    @NSManaged public var wasRead: Bool
    @NSManaged public var feed: Feed?

}
