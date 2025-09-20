
import UIKit

final class AppCoordinator {
    private let window: UIWindow

    init(window: UIWindow) { self.window = window }

    func start() {
        // Assemble dependencies
        let api = DefaultCountriesAPI()
        let remote = DefaultCountriesRemoteDataSource(api: api)
        let repo = DefaultCountriesRepository(remote: remote)
        let fetch = DefaultFetchCountriesUseCase(repo: repo)
        let filter = DefaultFilterCountriesUseCase()

        let vc = CountriesViewController(fetchUseCase: fetch, filterUseCase: filter)
        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}
