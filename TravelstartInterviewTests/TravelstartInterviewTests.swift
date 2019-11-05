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

    let rootVC = RootViewController()
    
    override func setUp() {
        rootVC.touristSitesProvider = MockAPIManager()
        rootVC.changeUIByStatus = { status in
            
        }
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func test() {
        rootVC.fetchTouristSites()
        XCTAssertEqual(rootVC.status, .empty)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


}

class MockAPIManager: APIManagerProtocol {
    func fetchTouristSite(limit: Int, offset: Int, resultHandler: @escaping (Result<TouristSitesResult, Error>) -> Void) {
        
        // empty
        resultHandler(Result.success(TouristSitesResult(limit: 10, offset: 0, count: 20, results: [])))
        
    }
    
    var isNetworkConnect: Bool = true
    
}
