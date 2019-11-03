//
//  BaseViewController.swift
//  TravelstartInterview
//
//  Created by iching chen on 2019/10/30.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetting()
        // Do any additional setup after loading the view.
    }
    
    static var identifier: String {
        
        return String(describing: self)
    }

    // 設定 navigationbar 文字顏色、按鈕
    func navigationBarSetting() {
        // navigation bar tint color
        self.navigationController?.navigationBar.tintColor = .white
        
        // navigation bar back button text
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        // navigation bar 背景色
        self.navigationController?.navigationBar.barTintColor = UIColor.TSBlue
        
        // navigation bar title text color
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

}
