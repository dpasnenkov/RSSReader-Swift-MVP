//
//  RSSListPresenter.swift
//  RSSReader
//
//  Created by Dmitry Pasnenkov on 4/5/20.
//  Copyright © 2020 Dmitry Pasnenkov. All rights reserved.
//

import Foundation
import CoreData

protocol RSSList: class {
    func showDetailNews()
    func reloadData ()
    func beginUpdatesTableView()
    func endUpdatesTableView()
    func tableViewInsertRowsAt (indexPath: IndexPath?)
    func tableViewUpdateRowsAt (indexPath: IndexPath?)
    func loadingViewHide(_ hide: Bool)
}

class RSSListPresenter: NSObject {
    
    var newsCount: Int {
        return fetchController.fetchedObjects?.count ?? 0
    }
    
    var currentIndex: IndexPath?
    lazy var fetchController = DBManager.getFetchedResultsController ()
    
    private weak var view: RSSList?
    
    init(view: RSSList) {
        
        self.view = view

        let rssManager = RSSManager()
        rssManager.configure()
        
        super.init()
        
        fetchController.delegate = self
        try? fetchController.performFetch()

        view.loadingViewHide(!(fetchController.fetchedObjects?.isEmpty ?? false))
    }
    
    func news(at indexPath: IndexPath) -> NewsDTO {
        return NewsDTO(item: fetchController.object(at: indexPath))
    }
    
    func showDetailView(with newsIndex: IndexPath) {
        currentIndex = newsIndex
        view?.showDetailNews()
        DBManager.setRead(link: news(at: newsIndex).link)
    }
    
    func getNextPresenter (for view: DetailNews) -> DetailNewsPresenter {
        return DetailNewsPresenter(news: news(at: currentIndex!), view: view)
    }
}

extension RSSListPresenter: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        view?.beginUpdatesTableView()
}
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            view?.tableViewInsertRowsAt(indexPath: newIndexPath)
//        case .delete:
//                return
//        case .move:
//                return
        case .update:
            view?.tableViewUpdateRowsAt(indexPath: indexPath)
        default:
            return
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        view?.endUpdatesTableView()
//        updateRSSList()
    }
}
