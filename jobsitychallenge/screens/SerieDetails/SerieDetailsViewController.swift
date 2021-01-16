//
//  SerieDetailsTableViewController.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 16/01/21.
//

import UIKit

class SerieDetailsViewController: UIViewController {

    // MARK: - Variables

    let viewModel = SerieDetailsViewModel()
    let serieDetailsView = SerieDetailsView()

    override func viewDidLoad() {
        super.viewDidLoad()

        config()

        viewModel.getEpisodesByShowId { [weak self] in
            self?.serieDetailsView.tableView.reloadData()
        }
    }

    // MARK: - Config

    private func config() {
        viewSetup()
        setConstraints()
    }

    // MARK: - View Setup

    private func viewSetup() {
        self.serieDetailsView.tableView.delegate = self
        self.serieDetailsView.tableView.dataSource = self
        self.view.addSubview(serieDetailsView)
    }

    // MARK: - Constraints

    private func setConstraints() {
        self.serieDetailsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

// MARK: - TableView Delegate and DataSource

extension SerieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.episodes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = serieDetailsView.tableView.dequeueReusableCell(withIdentifier: Constants.serieDetailsCellIdentifier) as? SerieDetailsTableViewCell ?? SerieDetailsTableViewCell()
        cell.textLabel?.text = self.viewModel.episodes[indexPath.row].name
        return cell
    }
}
