//
//  SitesListDescriptionTableViewCell.swift
//  TravelstartInterview
//
//  Created by iching chen on 2019/11/5.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class SitesListDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func layoutCell(description: String) {
        descriptionLabel.text = description
    }
    
}
