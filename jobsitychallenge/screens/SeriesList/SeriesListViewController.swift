//
//  ViewController.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 14/01/21.
//

import UIKit

class SeriesListViewController: UITableViewController {

    // MARK: - Variables

    let viewModel = SeriesListViewModel()

    // MARK: - UI Elements

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = .white
        activity.style = .large
        activity.isHidden = true
        return activity
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: Constants.seriesListCellIdentifier
        )

        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = UIColor(named: Constants.background)
        self.viewModel.getMoviesList {[weak self] in
            self?.tableView.reloadData()
        }

        setConstraints()
        navigationSetUp()
    }

    // MARK: - Constraints

    private func setConstraints() {

    }

    // MARK: - Navigation Setup

    private func navigationSetUp() {

        self.title = "Jobsity series"
        let magnifyingGlass = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass" ), style: .plain, target: self, action: #selector(searchButtonPressed))
        let gearShape = UIBarButtonItem(image: UIImage(systemName: "gearshape" ), style: .plain, target: self, action: #selector(searchButtonPressed))

        navigationItem.rightBarButtonItems = [magnifyingGlass, gearShape]
    }

    // MARK: - Actions

    @objc private func searchButtonPressed() {
        let searchViewController = SearchViewController()
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }

    @objc private func configButtonPressed() {
        print("🤬")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.seriesList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSerie = viewModel.seriesList[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(
            withIdentifier: Constants.seriesListCellIdentifier
        ) as? SeriesListTableViewCell ?? SeriesListTableViewCell()
        cell.set(serie: currentSerie)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentSerie = self.viewModel.seriesList[indexPath.row]
        let serieDetails = SerieDetailsViewController()
        serieDetails.viewModel.showId = currentSerie.id
        serieDetails.viewModel.showName = currentSerie.name
        self.navigationController?.pushViewController(serieDetails, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
}

extension SeriesListViewController: UISearchBarDelegate {

}
