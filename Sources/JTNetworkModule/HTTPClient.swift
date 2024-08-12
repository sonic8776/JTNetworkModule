//
//  HTTPClient.swift
//  JTNetwork
//
//  Created by Judy Tsai on 2024/6/18.
//

import Foundation

public enum HTTPClientError: Error {
    case networkError
    case cannotFindDataOrResponse
    
    
}

public protocol HTTPClient {
    func request(withRequestType requestType: RequestType, completion: @escaping (Result<(Data, HTTPURLResponse), HTTPClientError>) -> Void)
}
