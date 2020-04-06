//
//  DBManager.swift
//  RSSReader
//
//  Created by Dmitry Pasnenkov on 4/5/20.
//  Copyright © 2020 Dmitry Pasnenkov. All rights reserved.
//

import Foundation
import FeedKit
import CoreData

class DBManager {
    
    static func update (with rssFeed: RSSFeed) {
        
        print("begin update \(rssFeed.title ?? "")")
        
        let childMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
         
        childMOC.parent = CoreDataStack.shared.mainContext
        
        childMOC.perform { [weak rssFeed] in
            guard let rssFeed = rssFeed, let rssFeedlink = rssFeed.link else { return }
            
            let feedfRequest : NSFetchRequest<Feed> = Feed.fetchRequest()
            let predicate = NSPredicate(format: "link == %@", rssFeedlink)
            feedfRequest.predicate = predicate
            
            let feed: Feed = (try? childMOC.fetch(feedfRequest).first) ?? Feed(context: childMOC)
            
            add(rssFeed: rssFeed, to: feed)
                    
            if let rssItems = rssFeed.items {
                add(rssItems: rssItems, forFeed: feed, moc: childMOC)
            }
            
            do {
                try childMOC.save()
                CoreDataStack.shared.mainContext.performAndWait {
                    CoreDataStack.shared.saveContext()
                    print("end update")

                }
            }
            catch {
                fatalError("Failure to save context: \(error)")
            }

        }        
    }

    static private func add (rssFeed: RSSFeed, to feed: Feed) {
        
        feed.title = rssFeed.title
        feed.link = rssFeed.link
        
        if let urlImage = rssFeed.image?.url, let url = URL(string: urlImage) {
            feed.image = try? Data(contentsOf: url)
        }
    }

    static private func add (rssItems: [RSSFeedItem], forFeed feed: Feed, moc: NSManagedObjectContext) {
        
        let itemfRequest : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "feed == %@", feed)
        itemfRequest.predicate = predicate

        let items = try? CoreDataStack.shared.mainContext.fetch(itemfRequest)
        
        rssItems.forEach { rssItem in
            let isContained = items?.contains(where: { $0.link == rssItem.link }) ?? false
            if  !isContained {
                insertItem(for: rssItem, and: feed, moc: moc)
            }
        }
    }
        
    static private func insertItem (for rssItem: RSSFeedItem, and feed: Feed, moc: NSManagedObjectContext) {
        let item = Item(entity: Item.entity(), insertInto: moc)
        
        item.title = rssItem.title
        item.autor = rssItem.author
        item.link = rssItem.link
//        item.categories = rssItem.categories
//        item.content = rssItem.content
        item.descr = rssItem.description
        
        if let urlImage = rssItem.enclosure?.attributes?.url, let url = URL(string: urlImage) {
            item.image = try? Data(contentsOf: url)
        }

        item.pubDate = rssItem.pubDate
        item.wasRead = false
        item.feed = feed
    }
    
    static func setRead (link: String?) {
        
        guard let link = link else { return }
        
        let itemfRequest : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "link == %@", link)
        itemfRequest.predicate = predicate
        
        if let item: Item = try? CoreDataStack.shared.mainContext.fetch(itemfRequest).first {
            item.wasRead = true
            CoreDataStack.shared.saveContext()
        }
        
    }
    
    static func getFetchedResultsController () -> NSFetchedResultsController<Item> {
        let itemfRequest : NSFetchRequest<Item> = Item.fetchRequest()
        itemfRequest.sortDescriptors = [NSSortDescriptor(key: "pubDate", ascending: false)]

        return NSFetchedResultsController(fetchRequest: itemfRequest,
                                          managedObjectContext: CoreDataStack.shared.mainContext,
                                          sectionNameKeyPath: nil,
                                          cacheName: nil)

    }
}
