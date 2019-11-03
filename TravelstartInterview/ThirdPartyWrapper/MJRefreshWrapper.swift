//
//  MJRefreshWrapper.swift
//  TravelstartInterview
//
//  Created by iching chen on 2019/11/3.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import MJRefresh

extension UITableView {
    func addRefreshFooter(refreshingBlock: @escaping () -> Void) {

        mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: refreshingBlock)
    }

    func endFooterRefreshing() {

        mj_footer.endRefreshing()
    }

    func endWithNoMoreData() {

        mj_footer.endRefreshingWithNoMoreData()
    }
    
    func resetNoMoreData() {
        
        mj_footer.resetNoMoreData()
    }
}
