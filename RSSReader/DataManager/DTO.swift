//
//  News.swift
//  RSSReader
//
//  Created by Dmitry Pasnenkov on 4/5/20.
//  Copyright © 2020 Dmitry Pasnenkov. All rights reserved.
//

import Foundation

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
    var image: Data?
    var link: String?
    var pubDate: Date?
    var title: String?
    var wasRead: Bool
    var feed: FeedDTO?
    
    init(item: Item) {
        author = item.autor
        categories = item.categories
        content = item.content
        descr = item.descr
        image = item.image
        link = item.link
        pubDate = item.pubDate
        title = item.title
        wasRead = item.wasRead
        feed = FeedDTO(feed: item.feed)
    }
}
