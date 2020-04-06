//
//  DetailNewsPresenter.swift
//  RSSReader
//
//  Created by Dmitry Pasnenkov on 4/5/20.
//  Copyright © 2020 Dmitry Pasnenkov. All rights reserved.
//

import UIKit
protocol DetailNews: class {
}

class DetailNewsPresenter: NSObject {
    
    var news: NewsDTO
    private weak var view: DetailNews?
    
    init(news: NewsDTO, view: DetailNews) {
        self.news = news
        self.view = view
    }
}
