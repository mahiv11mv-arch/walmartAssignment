
import Foundation

public protocol CountriesRemoteDataSource {
    func loadCountries(completion: @escaping (Result<[Country], Error>) -> Void)
}

public final class DefaultCountriesRemoteDataSource: CountriesRemoteDataSource {
    private let api: CountriesAPI
    public init(api: CountriesAPI) { self.api = api }
    public func loadCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        api.fetchCountries(completion: completion)
    }
}
