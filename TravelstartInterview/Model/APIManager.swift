//
//  APIManager.swift
//  TravelstartInterview
//
//  Created by iching chen on 2019/11/1.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import Network

@objcMembers class APIManager: NSObject {
    
    static let shared = APIManager()
    
    let decoder = JSONDecoder()
    
    let monitor = NWPathMonitor()
    var isNetworkConnect = false
    
//    dynamic var touristSitesData: [TouristSites] = []
    
    private override init() {
        super.init()
        setupNetworkObserver()
    }
    
    func setupNetworkObserver() {
        monitor.pathUpdateHandler = {[weak self] path in
            if path.status == .satisfied {
                self?.isNetworkConnect = true
                print("connected")
            } else {
                self?.isNetworkConnect = false
                print("no connection")
            }
        }
        monitor.start(queue: DispatchQueue.global())
    }
    
    
    func fetchTouristSite(limit: Int = 10,
                          offset: Int,
                          resultHandler: @escaping (Result<TouristSitesResult, Error>) -> Void) {
            
        HTTPClient.shared.httpRequest(request: TouristSitesRequest.TaipeiTouristSites(limit: limit, offest: offset)) { result in
            
                switch result {
                    
                case .success(let data):
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let touristSiteData = try decoder.decode(TouristSites.self, from: data)
//                        print(touristSiteData.result.results)
//                        self.touristSitesData.append(touristSiteData)
                        resultHandler(Result.success(touristSiteData.result))
                        
                    } catch let error {
                        resultHandler(Result.failure(error))
                        print(error)
                    }
                    
                case .failure(let error):
                    resultHandler(Result.failure(error))
                    print(error)
            }
        }
    }
    
//    func resetTouristSitesData() {
//        touristSitesData = []
//    }
}
