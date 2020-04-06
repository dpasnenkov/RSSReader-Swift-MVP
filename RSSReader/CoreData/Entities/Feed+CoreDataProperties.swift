//
//  Feed+CoreDataProperties.swift
//  
//
//  Created by Dmitry Pasnenkov on 4/5/20.
//
//

import Foundation
import CoreData


extension Feed {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Feed> {
        return NSFetchRequest<Feed>(entityName: "Feed")
    }

    @NSManaged public var image: Data?
    @NSManaged public var link: String?
    @NSManaged public var title: String?

}
