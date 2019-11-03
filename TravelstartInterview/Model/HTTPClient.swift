//
//  HTTPClient.swift
//  TravelstartInterview
//
//  Created by iching chen on 2019/10/31.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation


enum TSHTTPClientError: Error {
    
    case decodeDataFail
    
    case clientError(Data)
    
    case serverError
    
    case unexpectedError
    
    case makeRequsetError
}

enum TSHTTPMethod: String {
    case GET
    case POST
}

class HTTPClient {
    static let shared = HTTPClient()
    
    private let decoder = JSONDecoder()
    
    private let encoder = JSONEncoder()
    
    private init() {}
    
    func httpRequest(request: Request,
                     completion: @escaping (Result<Data, Error>) -> Void) {
        guard
            let request = request.makeRequest()
        else {
            completion(Result.failure(TSHTTPClientError.makeRequsetError))
            return
        }
        
        URLSession.shared.dataTask(
            with: request,
            completionHandler: { data, response, error in
                guard error == nil else {
                    return completion(Result.failure(error!))
                }
                
                let httpResponse = response as! HTTPURLResponse
                
                let statusCode = httpResponse.statusCode
                
                switch statusCode {
                case 200..<300:
                    
                    guard data != nil else {
                        return completion(Result.failure(TSHTTPClientError.unexpectedError))
                    }
                    
                    completion(Result.success(data!))
                    
                case 400..<500:
                    
                    guard data != nil else {
                       return completion(Result.failure(TSHTTPClientError.unexpectedError))
                    }
                    
                    completion(Result.failure(TSHTTPClientError.clientError(data!)))
                    
                case 500..<600:
                    
                    completion(Result.failure(TSHTTPClientError.serverError))
                    
                default: return
                    
                    completion(Result.failure(TSHTTPClientError.unexpectedError))
                    
                }
                
        }).resume()
    }
    
}

protocol Request {
    var headers: [String: String] { get }
    var body: Data? { get }
    var method: String { get }
    var endPoint: URLComponents { get }
}

extension Request {
    func makeRequest() -> URLRequest? {
        guard
            let url = endPoint.url
        else {
            return nil
        }
        var request = URLRequest(url: url)
        
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        request.httpMethod = method
        
        return request
    }
}
