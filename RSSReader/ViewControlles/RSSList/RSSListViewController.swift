//
//  ViewController.swift
//  RSSReader
//
//  Created by Dmitry Pasnenkov on 4/4/20.
//  Copyright © 2020 Dmitry Pasnenkov. All rights reserved.
//

import UIKit

class RSSListViewController: UIViewController {
    
    @IBOutlet weak var rssTableView: UITableView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    var presenter: RSSListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = RSSListPresenter(view: self)
        rssTableView.tableFooterView = UIView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailNewsViewController {
            vc.presenter = presenter.getNextPresenter(for: vc)
        }
    }
}

extension RSSListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print ("rssList.count \(presenter.newsCount)")
        return presenter.newsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: String(describing: RSSTableViewCell.self), for: indexPath) as! RSSTableViewCell
        
        cell.configure(item: presenter.news(at: indexPath))
        
        return cell
    }
}

extension RSSListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showDetailView(with: indexPath)
    }
}

extension RSSListViewController: RSSListView {
    func loadingViewHide(_ hide: Bool) {
        loadingLabel.isHidden = hide
    }
    
    func beginUpdatesTableView() {
        rssTableView.beginUpdates()
    }
    
    func endUpdatesTableView() {
        rssTableView.endUpdates()
    }
    
    func tableViewInsertRowsAt(indexPath: IndexPath?) {
        guard let indexPath = indexPath else {
            rssTableView.reloadData()
            return
        }
        
        rssTableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func tableViewUpdateRowsAt(indexPath: IndexPath?) {
        guard let indexPath = indexPath,
            let cell = rssTableView.cellForRow(at: indexPath) as? RSSTableViewCell else { return }
        
        cell.configure(item: presenter.news(at: indexPath))
        
    }
    
    func reloadData() {
        rssTableView.reloadData()
    }
    
    func showDetailNews() {
        performSegue(withIdentifier: "GoToDetail", sender: self)
    }
}
