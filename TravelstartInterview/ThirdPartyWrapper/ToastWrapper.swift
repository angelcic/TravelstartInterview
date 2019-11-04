//
//  ToastWrapper.swift
//  TravelstartInterview
//
//  Created by iching chen on 2019/11/4.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import Toast_Swift

extension UIView {
    func acMakeToast(_ text: String, duration: Double, position: Toast_Swift.ToastPosition) {
        self.makeToast(text, duration: duration, position: position)
    }
}
