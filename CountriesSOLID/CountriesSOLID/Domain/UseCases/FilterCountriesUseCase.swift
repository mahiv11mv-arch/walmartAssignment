
import Foundation

public protocol FilterCountriesUseCase {
    func execute(query: String, in countries: [Country]) -> [Country]
}

public final class DefaultFilterCountriesUseCase: FilterCountriesUseCase {
    public init() {}
    public func execute(query: String, in countries: [Country]) -> [Country] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else { return countries }
        let lower = q.lowercased()
        return countries.filter { c in
            c.name.lowercased().contains(lower) || c.capital.lowercased().contains(lower)
        }
    }
}
