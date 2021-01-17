//
//  EpisodeDetailsViewController.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 16/01/21.
//

import UIKit

class EpisodeDetailsViewController: UIViewController {

    // MARK: - Variables

    let episodeDetailsView = EpisodeDetailsView()
    let viewModel = EpisodeDetailsViewModel()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }

    // MARK: - View SetUp

    private func config() {
        viewConfig()
        setConstraints()
    }

    private func viewConfig() {
        self.view.backgroundColor = UIColor(named: Constants.background)
        self.view.addSubview(episodeDetailsView)
        if let episode = viewModel.episode {
            episodeDetailsView.set(episode: episode)
        }
    }

    // MARK: - Constraints

    private func setConstraints() {
        episodeDetailsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
