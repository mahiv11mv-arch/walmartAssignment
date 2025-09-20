
import Foundation

public protocol CountriesAPI {
    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void)
}

public final class DefaultCountriesAPI: CountriesAPI {
    private let endpoint: URL
    private let session: NetworkSession

    public init(endpoint: URL = URL(string: "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json")!,
                session: NetworkSession = URLSessionNetworkSession()) {
        self.endpoint = endpoint
        self.session = session
    }

    public func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        let request = URLRequest(url: endpoint, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 20)
        session.data(for: request) { result in
            switch result {
            case .failure(let error): completion(.failure(error))
            case .success((let data, let response)):
                guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
                    completion(.failure(URLError(.badServerResponse))); return
                }
                do {
                    let countries = try JSONDecoder().decode([Country].self, from: data)
                    completion(.success(countries))
                } catch { completion(.failure(error)) }
            }
        }
    }
}
