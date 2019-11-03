//
//  DetailStringTableViewCell.swift
//  TravelstartInterview
//
//  Created by iching chen on 2019/11/4.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class DetailStringTableViewCell: UITableViewCell {
    
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var innerText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func layoutCell(title: String, text: String?) {
        subtitle.text = title
        innerText.text = text
    }
    
    
}
