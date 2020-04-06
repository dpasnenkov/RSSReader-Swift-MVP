//
//  DetailNewsViewController.swift
//  RSSReader
//
//  Created by Dmitry Pasnenkov on 4/5/20.
//  Copyright © 2020 Dmitry Pasnenkov. All rights reserved.
//

import UIKit

class DetailNewsViewController: UIViewController {

//    @IBOutlet weak var feedLogoImageView: UIImageView!
    @IBOutlet weak var feedTitleLabel: UILabel!
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    
    var presenter: DetailNewsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let news = presenter.news
        feedTitleLabel.text = news.feed?.title
        newsImageView.image = news.image
        newsTitleLabel.text = news.title
        newsDateLabel.text = news.pubDateStr
        newsDescriptionLabel.text = news.descr
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailNewsViewController: DetailNews {
    func configureUI(with item: Item) {
        
    }
    
    
}
