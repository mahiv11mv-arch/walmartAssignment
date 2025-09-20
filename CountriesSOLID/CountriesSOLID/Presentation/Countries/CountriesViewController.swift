
import UIKit

final class CountriesViewController: UITableViewController, UISearchResultsUpdating {
    private let fetchUseCase: FetchCountriesUseCase
    private let filterUseCase: FilterCountriesUseCase

    private var countries: [Country] = []
    private var filtered: [Country] = []

    private let searchController = UISearchController(searchResultsController: nil)
    private let emptyView = EmptyStateView()
    private let errorView = ErrorStateView()

    init(fetchUseCase: FetchCountriesUseCase, filterUseCase: FilterCountriesUseCase) {
        self.fetchUseCase = fetchUseCase
        self.filterUseCase = filterUseCase
        super.init(style: .plain)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        tableView.register(CountryCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 72

        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search name or capital"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        errorView.button.addTarget(self, action: #selector(retry), for: .touchUpInside)

        load()
    }

    @objc private func retry() { load() }

    private func load() {
        setBackground(view: nil)
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        tableView.backgroundView = spinner

        fetchUseCase.execute { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.tableView.backgroundView = nil
                switch result {
                case .success(let list):
                    self.countries = list
                    self.applyFilter()
                    if list.isEmpty { self.setBackground(view: self.emptyView) }
                case .failure(let error):
                    self.errorView.label.text = "Error: \(error.localizedDescription)"
                    self.setBackground(view: self.errorView)
                }
            }
        }
    }

    private func setBackground(view: UIView?) { tableView.backgroundView = view }

    private func applyFilter() {
        let q = searchController.searchBar.text ?? ""
        filtered = filterUseCase.execute(query: q, in: countries)
        tableView.reloadData()
        if !q.isEmpty && filtered.isEmpty { setBackground(view: emptyView) } else if tableView.backgroundView === emptyView { setBackground(view: nil) }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { filtered.count }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CountryCell
        cell.configure(with: filtered[indexPath.row])
        return cell
    }

    func updateSearchResults(for searchController: UISearchController) { applyFilter() }
}
