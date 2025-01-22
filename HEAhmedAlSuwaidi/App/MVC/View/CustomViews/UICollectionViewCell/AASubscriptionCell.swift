//
//  AASubscriptionCell.swift
//  HEAhmedAlSuwaidi
//
//  Created by Sreekanth R on 24/08/19.
//  Copyright © 2019 Electronic Village. All rights reserved.
//

import UIKit

class AASubscriptionCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
