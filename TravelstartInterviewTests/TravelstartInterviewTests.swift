//
//  TravelstartInterviewTests.swift
//  TravelstartInterviewTests
//
//  Created by iching chen on 2019/10/30.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import XCTest
@testable import TravelstartInterview

class TravelstartInterviewTests: XCTestCase {

    let rootVC = UIStoryboard.main.instantiateViewController(identifier: RootViewController.identifier) as! RootViewController
    
    override func setUp() {
//        rootVC.touristSitesProvider = MockAPIManager()
        rootVC.touristSitesProvider.httpClient = MockHTTPClient.shared
        rootVC.loadViewIfNeeded()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func test() {
        rootVC.fetchTouristSites()
        XCTAssertEqual(rootVC.status, .empty)
    }
    
    func testFetchResultFailed() {
        rootVC.fetchTouristSites()
        XCTAssertEqual(rootVC.status, .error)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


}

class MockAPIManager: APIManagerProtocol {
    var httpClient: HTTPClient = HTTPClient.shared
    
    func fetchTouristSite(limit: Int, offset: Int, resultHandler: @escaping (Result<TouristSitesResult, Error>) -> Void) {
        
        // empty
//        resultHandler(Result.success(TouristSitesResult(limit: 10, offset: 0, count: 20, results: [])))
        
        // error
        resultHandler(Result.failure(testError.error))
        
    }
    
    var isNetworkConnect: Bool = true
    
}

enum testError: Error {
    case error
}

class MockHTTPClient: HTTPClient {
    override func httpRequest(request: Request, completion: @escaping (Result<Data, Error>) -> Void) {
        
//        let data = "".data(using: <#T##String.Encoding#>)
        completion(Result.failure(testError.error))
    }
}
