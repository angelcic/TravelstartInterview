//
//  UIColorExtension.swift
//  TravelstartInterview
//
//  Created by iching chen on 2019/10/31.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import UIKit

private enum TSColor: String {
    case TSBlue
}


extension UIColor {
    static let TSBlue = TSColor(.TSBlue)
    
    private static func TSColor(_ color: TSColor) -> UIColor? {
        let resultColor = UIColor(named: color.rawValue)
        return resultColor
    }
}
