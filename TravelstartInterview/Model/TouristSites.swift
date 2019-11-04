//
//  TouristSites.swift
//  TravelstartInterview
//
//  Created by iching chen on 2019/10/31.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

struct TouristSites: Codable {
    let result: TouristSitesResult
}

struct TouristSitesResult: Codable {
    let limit: Int
    let offset: Int
    let count: Int
    let results: [TouristSitesDetail]
}

struct TouristSitesDetail: Codable {
    let stitle: String
    let xbody: String
    let address: String // 地址
    let memoTime: String? // 營業時間
    let info: String? // 交通資訊
    let longitude: String
    let latitude: String
    let xpostDate: String?
    let file: String // 照片影音資訊

    enum CodingKeys: String, CodingKey {
        case memoTime = "MEMO_TIME"
        case stitle, xbody, address, info, longitude, latitude, xpostDate, file
    }
}

extension TouristSitesDetail {
    var images: [String] {
        return decodeTouristFileURLString(file)
    }
    
    func decodeTouristFileURLString(_ urlString: String) -> [String] {
        let urlArray: [String] = urlString.lowercased().components(separatedBy: "http").compactMap {
            if $0.isEmpty || !$0.contains("jpg") {
                return nil
            } else {
                return "http" + $0
            }
        }
        return urlArray
    }
}

struct DetailContent {
    let subtitle: String
    let contentText: String?
}
