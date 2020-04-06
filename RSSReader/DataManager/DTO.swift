//
//  News.swift
//  RSSReader
//
//  Created by Dmitry Pasnenkov on 4/5/20.
//  Copyright © 2020 Dmitry Pasnenkov. All rights reserved.
//

import Foundation
import UIKit

struct FeedDTO {
    var image: Data?
    var link: String?
    var title: String?

    init(feed: Feed?) {
        image = feed?.image
        link = feed?.link
        title = feed?.title
    }
}

struct NewsDTO {
    var author: String?
    var categories: String?
    var content: String?
    var descr: String?
    var dataImage: Data?
    var link: String?
    var pubDate: Date?
    var title: String?
    var wasRead: Bool
    var feed: FeedDTO?

    var image: UIImage? {
        guard let dataImage = self.dataImage else { return nil }
        return UIImage(data: dataImage)
    }
    
    var pubDateStr: String? {
        guard let pubDate = self.pubDate else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm"
        
        return dateFormatter.string(from: pubDate)
    }

    
    init(item: Item) {
        author = item.autor
        categories = item.categories
        content = item.content
        descr = item.descr
        dataImage = item.image
        link = item.link
        pubDate = item.pubDate
        title = item.title
        wasRead = item.wasRead
        feed = FeedDTO(feed: item.feed)
    }
    
}
