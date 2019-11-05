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
  
    func testFetchTouristSiteResultError() {
        let apiManager = APIManager(httpClient: MockErrorHTTPClient())
        var APIResult: Bool = true
        
        apiManager.fetchTouristSite() { result in
            
            switch result {
            case .success:
                APIResult = true
            case .failure:
                APIResult = false
            }
        }

        XCTAssertEqual(APIResult, false)
    }
    
    func testFetchTouristSiteResultSuccess() {
        let apiManager = APIManager(httpClient: MockSuccessHTTPClient())
        var APIResult: Bool = true
        apiManager.fetchTouristSite() { result in
            switch result {
            case .success:
                APIResult = true
            case .failure:
                APIResult = false
            }
        }
        XCTAssertEqual(APIResult, true)
    }
    
    func testFetchTouristSiteResultWrongJSON() {
        let apiManager = APIManager(httpClient: MockWrongJSONHTTPClient())
        var APIResult: Bool = true
        apiManager.fetchTouristSite() { result in
            switch result {
            case .success:
                APIResult = true
            case .failure:
                APIResult = false
            }
        }
        XCTAssertEqual(APIResult, false)
    }

}

enum testError: Error {
    case error
}

class MockErrorHTTPClient: HTTPClient {
    
    override func httpRequest(request: Request, completion: @escaping (Result<Data, Error>) -> Void) {
        
        completion(Result.failure(testError.error))
    }
}

class MockSuccessHTTPClient: HTTPClient {
    
    override func httpRequest(request: Request, completion: @escaping (Result<Data, Error>) -> Void) {
        
        let jsonData = """
{
    "result": {
        "limit": 1,
        "offset": 0,
        "count": 319,
        "sort": "",
        "results": [
            {
                "info": "123",
                "stitle": "新北投溫泉區",
                "xpostDate": "2016/07/07",
                "longitude": "121.508447",
                "REF_WP": "10",
                "avBegin": "2010/02/14",
                "langinfo": "10",
                "MRT": "新北投",
                "SERIAL_NO": "2011051800000061",
                "RowNumber": "1",
                "CAT1": "景點",
                "CAT2": "養生溫泉",
                "MEMO_TIME": "各業者不同，依據現場公告",
                "POI": "Y",
                "file": "123",
                "idpt": "臺北旅遊網",
                "latitude": "25.137077",
                "xbody": "123",
                "_id": 1,
                "avEnd": "2016/07/07",
                "address": "臺北市  北投區中山路、光明路沿線"
            }
        ]
    }
}
""".data(using: .utf8)!
        
        completion(Result.success(jsonData))
    }
}

class MockWrongJSONHTTPClient: HTTPClient {
    
    override func httpRequest(request: Request, completion: @escaping (Result<Data, Error>) -> Void) {
       
        let jsonData = """
{
"test": { }
}
""".data(using: .utf8)!
        
        completion(Result.success(jsonData))
        
    }
}
