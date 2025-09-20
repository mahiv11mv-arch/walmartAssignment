
import XCTest
@testable import CountriesSOLID

final class FilterCountriesUseCaseTests: XCTestCase {
    func testFilter() {
        let useCase = DefaultFilterCountriesUseCase()
        let list = [
            Country(name: "United States of America", region: "NA", code: "US", capital: "Washington, D.C."),
            Country(name: "Uruguay", region: "SA", code: "UY", capital: "Montevideo")
        ]
        XCTAssertEqual(useCase.execute(query: "wash", in: list).map { $0.code }, ["US"])
        XCTAssertEqual(useCase.execute(query: "guay", in: list).map { $0.code }, ["UY"])
        XCTAssertEqual(useCase.execute(query: "", in: list).count, 2)
    }
}
