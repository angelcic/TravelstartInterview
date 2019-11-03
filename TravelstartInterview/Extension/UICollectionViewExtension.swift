//
//  UICollectionViewExtension.swift
//  TravelstartInterview
//
//  Created by iching chen on 2019/11/1.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

import UIKit

extension UICollectionView {

    func registerCellWithNib(identifier: String, bundle: Bundle?) {

        let nib = UINib(nibName: identifier, bundle: bundle)

        register(nib, forCellWithReuseIdentifier: identifier)
    }
}

extension UICollectionViewCell {
    
    static var identifier: String {
        
        return String(describing: self)
    }
}
