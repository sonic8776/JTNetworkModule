//
//  HTTPClientEndToEndTests.swift
//  JTNetworkTests
//
//  Created by Judy Tsai on 2024/6/18.
//

import XCTest
@testable import JTNetworkModule

class HTTPClientEndToEndTests: XCTestCase {
    // GET https://620962796df46f0017f4c4db.mockapi.io/users/userList?page=1&limit=10
    
    func test_request_onSuccessfulRequestCase() {
        let sut = makeSUT()
        let requestType = RequestTypeSpy(page: "1")
        let expectation = expectation(description: "Wait for completion!")
        
        sut.request(withRequestType: requestType) { result in
            expectation.fulfill()
            
            switch result {
            case let .success((data, _)):
            
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    if let jsonArray = json as? [[String: Any]] {
                        let elementCount = jsonArray.count
                        print("ElementCount = \(elementCount)")
                        XCTAssertEqual(elementCount, 10)
                    } else {
                        XCTFail("Should successfully parse json to array")
                    }
                    
                } catch {
                    XCTFail("The data should be parsed to Json!")
                }
            default:
                XCTFail("The API should be successful!")
            }
        }
        
        wait(for: [expectation], timeout: 30)
    }
}

private extension HTTPClientEndToEndTests {
    struct RequestTypeSpy: RequestType {
        init(page: String) {
            queryItems =  [
                .init(name: "page", value: page),
                .init(name: "limit", value: "10")
            ]
        }
        
        var baseURL: URL { .init(string: "https://620962796df46f0017f4c4db.mockapi.io")! }
        
        var path: String { "/users/userList" }
        
        var queryItems: [URLQueryItem] = []
        
        var method: JTNetworkModule.HTTPMethod { .get }
        
        var body: Data? { nil }
        
        var headers: [String: String]? { nil }
    }
    
    func makeSUT() -> HTTPClient {
        let session = URLSession(configuration: .ephemeral) // 確保沒有 cache
        let sut = URLSessionHTTPClient(session: session)
        return sut
    }
    
    
}
