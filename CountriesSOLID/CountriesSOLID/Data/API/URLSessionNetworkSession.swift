
import Foundation

public final class URLSessionNetworkSession: NetworkSession {
    private let session: URLSession
    public init(session: URLSession = .shared) { self.session = session }

    public func data(for request: URLRequest, completion: @escaping (Result<(Data, URLResponse), Error>) -> Void) {
        session.dataTask(with: request) { data, response, error in
            if let error = error { completion(.failure(error)); return }
            guard let data = data, let response = response else {
                completion(.failure(URLError(.badServerResponse))); return
            }
            completion(.success((data, response)))
        }.resume()
    }
}
