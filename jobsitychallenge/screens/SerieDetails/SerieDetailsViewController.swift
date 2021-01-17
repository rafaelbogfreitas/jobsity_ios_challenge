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

        viewModel.getEpisodesByShowId {
            DispatchQueue.main.async {
                self.serieDetailsView.tableView.reloadData()
            }
        }
    }

    // MARK: - Config

    private func config() {
        viewSetup()
        setConstraints()
    }

    // MARK: - View Setup

    private func viewSetup() {
        if let serie = self.viewModel.show {
            self.serieDetailsView.headerView.setViewWith(serie: serie)
        }
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
    func numberOfSections(in tableView: UITableView) -> Int {
        self.viewModel.seasons.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Season \(section + 1)"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.seasons[section]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = serieDetailsView.tableView.dequeueReusableCell(withIdentifier: Constants.serieDetailsCellIdentifier) as? EpisodeListItemTableViewCell ?? EpisodeListItemTableViewCell()
        if let currentEpisode = viewModel.seasons[indexPath.section]?[indexPath.row] {
            cell.set(episode: currentEpisode)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currentEpisode = viewModel.seasons[indexPath.section]?[indexPath.row] {
            let episodeDetailsViewController = EpisodeDetailsViewController()
            episodeDetailsViewController.viewModel.episode = currentEpisode
            self.navigationController?.pushViewController(episodeDetailsViewController, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
