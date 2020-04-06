//
//  RSSManager.swift
//  RSSReader
//
//  Created by Dmitry Pasnenkov on 4/5/20.
//  Copyright © 2020 Dmitry Pasnenkov. All rights reserved.
//

import FeedKit

class RSSManager {
    private let rssURLs = ["http://lenta.ru/rss",
                           "http://www.gazeta.ru/export/rss/lenta.xml"]
    
    static let shared = RSSManager()
        
    var repeatingTimer: RepeatingTimer?
    
    func loadRSSData () {
        
        for rssURL in rssURLs {
            
            guard let url = URL(string: rssURL) else { break }
            let parser = FeedParser (URL: url)
            
            parser.parseAsync { result in
                switch result {
                case .success(let feed):
                    
                    if let rssFeed = feed.rssFeed {
                        DBManager.update(with: rssFeed)
                    } else {
                        print ("no rss")
                    }
                    
                    // Grab the parsed feed directly as an optional rss, atom or json feed object
                    // Or alternatively...
    //                switch feed {
    //                case let .atom(feed): break      // Atom Syndication Format Feed Model
    //                case let .rss(feed): break        // Really Simple Syndication Feed Model
    //                case let .json(feed): break        // JSON Feed Model
    //                }
                    
                case .failure(let error):
                    print(error)
                }

            }
            
        }
        
    }
    
    func setReloadTimer()
    {
        repeatingTimer = RepeatingTimer(timeInterval: 5)
        
        guard let repeatingTimer = repeatingTimer else { return }
        
        repeatingTimer.eventHandler = { [unowned self] in
            self.loadRSSData()
        }
        
        repeatingTimer.resume()
    }
    
    func startUpdate () {
        loadRSSData ()
        setReloadTimer()
    }
}
