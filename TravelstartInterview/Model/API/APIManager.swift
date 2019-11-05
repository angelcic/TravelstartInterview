//
//  APIManager.swift
//  TravelstartInterview
//
//  Created by iching chen on 2019/11/1.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import Network

protocol APIManagerProtocol {
    func fetchTouristSite(limit: Int,
                          offset: Int,
                          resultHandler: @escaping (Result<TouristSitesResult, Error>) -> Void)
    
    var isNetworkConnect: Bool { get set }
//    var httpClient: HTTPClient { get set }
}

class APIManager: APIManagerProtocol {
    
    static let shared = APIManager()
    
    let decoder = JSONDecoder()
    
    let monitor = NWPathMonitor()
    
    let httpClient: HTTPClient
    
    var isNetworkConnect = false
    
    init(httpClient: HTTPClient = HTTPClient.shared) {
        self.httpClient = httpClient
        setupNetworkObserver()
    }
    
    func setupNetworkObserver() {
        monitor.pathUpdateHandler = {[weak self] path in
            if path.status == .satisfied {
                self?.isNetworkConnect = true
                print("connect")
            } else {
                self?.isNetworkConnect = false
                print("unconnect")
            }
        }
        monitor.start(queue: DispatchQueue.global())
    }
    
    func fetchTouristSite(limit: Int = 10,
                          offset: Int = 0,
                          resultHandler: @escaping (Result<TouristSitesResult, Error>) -> Void) {
        httpClient.httpRequest(request: TouristSitesRequest.TaipeiTouristSites(limit: limit, offest: offset)) { result in

                switch result {

                case .success(let data):

                    let decoder = JSONDecoder()

                    do {
                        let touristSiteData = try decoder.decode(TouristSites.self, from: data)
                        
                        resultHandler(Result.success(touristSiteData.result))

                    } catch let error {
                        resultHandler(Result.failure(error))
                    }

                case .failure(let error):
                    resultHandler(Result.failure(error))
            }
        }
    }
    
}
