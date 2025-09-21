
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

        // Storyboard-first instantiation
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(
            identifier: "CountriesViewController"
        ) as? CountriesViewController else {
            fatalError("Storyboard misconfigured: CountriesViewController")
        }

        // Property injection (DIP)
        vc.fetchUseCase = fetch
        vc.filterUseCase = filter

        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}
