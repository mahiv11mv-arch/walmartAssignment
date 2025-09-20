
import Foundation

public protocol NetworkSession {
    func data(for request: URLRequest, completion: @escaping (Result<(Data, URLResponse), Error>) -> Void)
}
