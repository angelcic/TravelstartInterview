//
//  KingFisherWrapper.swift
//  TravelstartInterview
//
//  Created by iching chen on 2019/11/3.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {

    func loadImage(_ urlString: String?, placeHolder: UIImage? = nil) {

        guard urlString != nil else {
            self.image = UIImage(named: "Image_Placeholder")
            return
            
        }
        
        let url = URL(string: urlString!)

        self.kf.setImage(with: url, placeholder: placeHolder)
    }
}
