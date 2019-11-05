//
//  TouristSitesListContentCategory.swift
//  TravelstartInterview
//
//  Created by iching chen on 2019/11/5.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import UIKit

enum TouristSitesListContentCategory {
    case title
    case description
    case imageCollectionView(vc: SitesListImageCellDelegate)
    
    func identifier() -> String {
        
        switch self {
            
        case .title:
            return SitesListTitleTableViewCell.identifier
            
        case .description:
            return SitesListDescriptionTableViewCell.identifier
            
        case .imageCollectionView:
            return SitesListImageTableViewCell.identifier
            
        }
    }
    
    func cellForIndexPath(_ indexPath: IndexPath, tableView: UITableView, data: TouristSitesDetail) -> UITableViewCell {
        
        let basicCell = tableView.dequeueReusableCell(withIdentifier: identifier(), for: indexPath)
                        
        switch self {
            
        case .title:
            
            guard
                let cell = basicCell as? SitesListTitleTableViewCell
            else {
                return basicCell
            }
            
            cell.layoutCell(title: data.stitle)
            return cell
            
        case .description:
            
            guard
                let cell = basicCell as? SitesListDescriptionTableViewCell
            else {
                return basicCell
            }
            
            cell.layoutCell(description: data.xbody)
            return cell
            
        case .imageCollectionView(let viewController):
            
            guard
                let cell = basicCell as? SitesListImageTableViewCell
            else {
                return basicCell
            }
            
            cell.delegate = viewController
            cell.layoutCell(images: data.images)
            return cell
        }
    }
}
