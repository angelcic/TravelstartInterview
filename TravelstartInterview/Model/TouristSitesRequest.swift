//
//  TouristSitesRequest.swift
//  TravelstartInterview
//
//  Created by iching chen on 2019/10/31.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

enum TouristSitesRequest: Request {
    
    case TaipeiTouristSites(limit: Int, offest: Int)
    
    var headers: [String : String] {
        switch self {
        case .TaipeiTouristSites:
            return [:]
        }
    }
 
    var body: Data? {
           switch self {
           case .TaipeiTouristSites:
               return nil
           }
       }
    
    var method: String {
           switch self {
           case .TaipeiTouristSites:
            return TSHTTPMethod.GET.rawValue
           }
       }
    
    var endPoint: URLComponents {
    
        switch self {
        case .TaipeiTouristSites(let limit, let offest):
           var urlComponent = URLComponents()
           urlComponent.scheme = "https"
           urlComponent.host = "data.taipei"
           urlComponent.path = "/opendata/datalist/apiAccess"
           urlComponent.queryItems = [
               URLQueryItem(name: "scope", value: "resourceAquire"),
               URLQueryItem(name: "rid", value: "36847f3f-deff-4183-a5bb-800737591de5"),
               URLQueryItem(name: "limit", value: "\(limit)"),
               URLQueryItem(name: "offset", value: "\(offest)")
           ]
           return urlComponent
        }
    }
}
