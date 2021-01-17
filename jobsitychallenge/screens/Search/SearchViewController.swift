//
//  SearchViewController.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 16/01/21.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Variables
    let searchView = SearchView()
    let viewModel = SearchViewModel()

    var isPeopleSearch = false

    // MARK: - SearchBar

    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = isPeopleSearch ? "Find a serie" : "Find someone"
        if #available(iOS 13.0, *) {
            search.searchBar.searchTextField.font = UIFont.systemFont(ofSize: 15)
        }
        search.obscuresBackgroundDuringPresentation = false
        search.hidesNavigationBarDuringPresentation = false
        return search
    }()

    init(isPeopleSearch: Bool? = nil) {
        self.isPeopleSearch = isPeopleSearch ?? false
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        config()
    }

    // MARK: - View Setup

    private func config() {
        navigationSetup()
        viewSetup()
        setContraints()
    }

    private func viewSetup() {
        self.view.addSubview(searchView)
        self.view.backgroundColor = UIColor(named: Constants.background)
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
        searchController.searchBar.delegate = self
    }

    // MARK: - Navigation SetUp

    private func navigationSetup() {

        self.navigationItem.title = isPeopleSearch ? "People Search" : "Serie Search"

        self.navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    // MARK: - Constraints

    private func setContraints() {
        searchView.snp.makeConstraints {
            $0.top.lessThanOrEqualToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }

    // MARK: - Methods

    private func showActivityIndicator() {
        searchView.placeholder.isHidden = true
        searchView.activityIndicator.isHidden = false
        searchView.activityIndicator.startAnimating()
    }

    private func hideActivityIndicator() {
        searchView.activityIndicator.isHidden = false
        searchView.activityIndicator.stopAnimating()
    }

    private func handleSearch(with string: String) {
        showActivityIndicator()
        let urlString = string.replacingOccurrences(of: " ", with: "%20")

        if !isPeopleSearch {
            viewModel.searchSeries(with: urlString) { [weak self] in
                guard let self = self else {return}
                self.hideActivityIndicator()

                if self.viewModel.series.isEmpty {
                    self.searchView.placeholder.messageLabel.text = "No results found. Try again."
                }

                self.searchView.tableView.isHidden = self.viewModel.series.isEmpty
                self.searchView.placeholder.isHidden = !self.viewModel.series.isEmpty

                self.searchView.tableView.reloadData()
            }
        } else {
            viewModel.searchPeople(with: urlString) { [weak self] in
                guard let self = self else {return}
                self.hideActivityIndicator()

                if self.viewModel.people.isEmpty {
                    self.searchView.placeholder.messageLabel.text = "No results found. Try again."
                }

                self.searchView.tableView.isHidden = self.viewModel.people.isEmpty
                self.searchView.placeholder.isHidden = !self.viewModel.people.isEmpty

                self.searchView.tableView.reloadData()
            }
        }

    }
}

// MARK: - TableView Delegate and DataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isPeopleSearch ? self.viewModel.people.count : self.viewModel.series.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isPeopleSearch {
            let currentPerson = viewModel.people[indexPath.row]
            let cell = searchView.tableView.dequeueReusableCell(withIdentifier: Constants.seriesListCellIdentifier) as? PeopleTableViewCell ?? PeopleTableViewCell()
            cell.set(serie: currentPerson)
            return cell
        } else {
            let currentSerie = viewModel.series[indexPath.row]
            let cell = searchView.tableView.dequeueReusableCell(withIdentifier: Constants.seriesListCellIdentifier) as? SeriesListTableViewCell ?? SeriesListTableViewCell()
            cell.set(serie: currentSerie)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isPeopleSearch {
            // TODO: - Navigate to People Detail
        } else {
            let currentSerie = viewModel.series[indexPath.row]
            let serieDetailsViewController = SerieDetailsViewController()
            serieDetailsViewController.viewModel.show = currentSerie
            self.navigationController?.pushViewController(serieDetailsViewController, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }

}

// MARK: - SearchController delegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            handleSearch(with: searchText)
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.viewModel.series.removeAll()
        self.searchView.tableView.reloadData()
        self.searchView.tableView.isHidden = true
        self.searchView.placeholder.isHidden = false
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let search = searchBar.text, search == "" {
            handleSearch(with: search)
        }
    }
}
