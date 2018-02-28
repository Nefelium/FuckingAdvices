//
//  FavoritesTableViewCell.swift
//  FuckingAdvices
//
//  Created by admin on 28.02.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var adviceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var advice: AdviceModel? {
        didSet {
            adviceLabel.text = advice?.text
        }
    }
    
}
