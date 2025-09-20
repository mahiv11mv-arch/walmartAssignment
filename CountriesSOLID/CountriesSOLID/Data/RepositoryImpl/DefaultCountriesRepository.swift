
import Foundation

public final class DefaultCountriesRepository: CountriesRepository {
    private let remote: CountriesRemoteDataSource
    public init(remote: CountriesRemoteDataSource) { self.remote = remote }
    public func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        remote.loadCountries(completion: completion)
    }
}
