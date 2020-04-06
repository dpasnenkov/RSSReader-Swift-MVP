//
//  RSSTableViewCell.swift
//  RSSReader
//
//  Created by Dmitry Pasnenkov on 4/5/20.
//  Copyright © 2020 Dmitry Pasnenkov. All rights reserved.
//

import UIKit

class RSSTableViewCell: UITableViewCell {

    @IBOutlet weak var rssImageView: UIImageView!
    @IBOutlet weak var rssTitleLabel: UILabel!
    @IBOutlet weak var wasReadIndicatorView: UIView!
    @IBOutlet weak var feedTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure (item: NewsDTO) {
        rssTitleLabel.text = item.title
        feedTitleLabel.text = item.feed?.title
        
        if let dataImage = item.image {
            rssImageView.image = UIImage(data: dataImage)
        }
        
        wasReadIndicatorView.isHidden = item.wasRead
        
    }

}
