//
//  UIStoryboardExtension.swift
//  TravelstartInterview
//
//  Created by iching chen on 2019/11/2.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

private struct StoryboardCategory {
    static let main = "Main"
}

extension UIStoryboard {
    static var main: UIStoryboard { return storyboard(name: StoryboardCategory.main) }

    private static func storyboard(name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }
}
