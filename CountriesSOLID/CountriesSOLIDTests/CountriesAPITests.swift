
import XCTest
@testable import YourAppModuleName

final class CountriesAPITests: XCTestCase {
    func testAPIParsesJSON() {
        let url = URL(string: "https://example.com/countries.json")!
        let json = "[{\"name\":\"Uruguay\",\"region\":\"SA\",\"code\":\"UY\",\"capital\":\"Montevideo\"}]".data(using: .utf8)!

        URLProtocolStub.testURLs = [url: json]
        URLProtocolStub.response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: config)
        let api = DefaultCountriesAPI(endpoint: url, session: URLSessionNetworkSession(session: session))

        let exp = expectation(description: "fetch")
        api.fetchCountries { result in
            switch result {
            case .success(let list):
                XCTAssertEqual(list.first?.code, "UY")
            case .failure:
                XCTFail("Expected success")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}

class URLProtocolStub: URLProtocol {
    static var testURLs = [URL: Data]()
    static var response: URLResponse?

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        if let url = request.url, let data = URLProtocolStub.testURLs[url] {
            if let response = URLProtocolStub.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } else {
            client?.urlProtocol(self, didFailWithError: URLError(.fileDoesNotExist))
        }
    }

    override func stopLoading() { }
}
