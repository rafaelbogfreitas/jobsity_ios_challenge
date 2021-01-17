//
//  SerieDetailsTableViewController.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 16/01/21.
//

import UIKit
import SkeletonView

class SerieDetailsViewController: UIViewController {

    // MARK: - Variables

    let viewModel = SerieDetailsViewModel()
    let serieDetailsView = SerieDetailsView()

    override func viewDidLoad() {
        super.viewDidLoad()

        config()

        viewModel.getEpisodesByShowId {
            DispatchQueue.main.async {
                self.serieDetailsView.hideSkeleton()
                self.serieDetailsView.tableView.reloadData()
            }
        }
    }

    // MARK: - Config

    private func config() {
        navigationSetUp()
        viewSetup()
        setConstraints()
    }

    // MARK: - View Setup

    private func viewSetup() {
        self.serieDetailsView.tableView.delegate = self
        self.serieDetailsView.tableView.dataSource = self
        self.view.addSubview(serieDetailsView)
        self.serieDetailsView.showAnimatedSkeleton()
        self.serieDetailsView.tableView.layoutIfNeeded()
    }

    // MARK: - Constraints

    private func setConstraints() {
        self.serieDetailsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Navigation Setup

    private func navigationSetUp() {
        self.title = self.viewModel.showName
    }
}

// MARK: - TableView Delegate and DataSource

extension SerieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.episodes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentEpisode = viewModel.episodes[indexPath.row]
        let cell = serieDetailsView.tableView.dequeueReusableCell(withIdentifier: Constants.serieDetailsCellIdentifier) as? SerieDetailsTableViewCell ?? SerieDetailsTableViewCell()
        cell.set(episode: currentEpisode)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentEpisode = self.viewModel.episodes[indexPath.row]
        let episodeDetailsViewController = EpisodeDetailsViewController()
        episodeDetailsViewController.viewModel.episode = currentEpisode
        self.navigationController?.pushViewController(episodeDetailsViewController, animated: true)

    }
}

extension SerieDetailsViewController: SkeletonTableViewDataSource {
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        1
    }
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        Constants.serieDetailsCellIdentifier
    }
}
