//
//  SitesListImageCollectionViewCell.swift
//  TravelstartInterview
//
//  Created by iching chen on 2019/11/1.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class SitesListImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func layoutCell(imageURL: String) {
        imageView.loadImage(imageURL)
    }

}
