
import Foundation

public protocol CountriesRepository {
    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void)
}
