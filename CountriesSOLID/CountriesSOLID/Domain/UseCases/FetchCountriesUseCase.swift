
import Foundation

public protocol FetchCountriesUseCase {
    func execute(completion: @escaping (Result<[Country], Error>) -> Void)
}

public final class DefaultFetchCountriesUseCase: FetchCountriesUseCase {
    private let repo: CountriesRepository
    public init(repo: CountriesRepository) { self.repo = repo }
    public func execute(completion: @escaping (Result<[Country], Error>) -> Void) {
        repo.fetchCountries(completion: completion)
    }
}
