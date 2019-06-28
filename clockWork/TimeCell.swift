//
//  TimeCell.swift
//  clockWork
//
//  Created by Phanindra on 28/06/19.
//  Copyright © 2019 Phanindra. All rights reserved.
//

import UIKit

class TimeCell: UITableViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var timezoneName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
