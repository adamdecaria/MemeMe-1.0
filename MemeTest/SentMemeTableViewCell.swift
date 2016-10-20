//
//  SentMemeTableViewCell.swift
//  MemeMe 1.0
//
//  Created by Adam DeCaria on 2016-10-20.
//  Copyright © 2016 Adam DeCaria. All rights reserved.
//

import UIKit

class SentMemeTableViewCell: UITableViewCell {

    @IBOutlet var memedImage: UIImage!
    @IBOutlet var topText: String!
    @IBOutlet var bottomText: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
