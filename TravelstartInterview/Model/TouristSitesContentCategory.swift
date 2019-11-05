//
//  TouristSitesContentCategory.swift
//  TravelstartInterview
//
//  Created by iching chen on 2019/11/5.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import UIKit

enum TouristSitesContentCategory: String {
    case name = "景點名稱"
    case description = "景點介紹"
    case address = "地址"
    case time = "開放時間"
    case traffic = "交通資訊"
    
    func identifier() -> String {
        
        switch self {
            
        case .description, .name, .address, .time, .traffic: return String(describing: DetailStringTableViewCell.self)
            
        }
    }
    
    func cellForIndexPath(_ indexPath: IndexPath, tableView: UITableView, data: TouristSitesDetail) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier(), for: indexPath)
                as? DetailStringTableViewCell
        else {
            return UITableViewCell()
            
        }
        
        switch self {
            
        case .name:
            cell.layoutCell(title: self.rawValue, text: data.stitle)
            
        case .description:
            cell.layoutCell(title: self.rawValue, text: data.xbody)
            
        case .address:
            cell.layoutCell(title: self.rawValue, text: data.address, isHiddenButton: false)
            
        case .time:
            cell.layoutCell(title: self.rawValue, text: data.memoTime)
            
        case .traffic:
            cell.layoutCell(title: self.rawValue, text: data.info)
        }
        return cell
    }
}
