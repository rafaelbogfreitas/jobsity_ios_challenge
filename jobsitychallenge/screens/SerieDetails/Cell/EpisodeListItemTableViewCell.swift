//
//  EpisodeListItemTableViewCell.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 15/01/21.
//

import UIKit
import Kingfisher

class EpisodeListItemTableViewCell: UITableViewCell {

    // MARK: - UI Elements

    lazy var episodeNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: Constants.mediumFont)
        return label
    }()

    lazy var episodeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.mediumFont)
        label.numberOfLines = 0
        return label
    }()

    lazy var episodePoster: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit

        return img
    }()

    // MARK: - Stacks
    lazy var textStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            episodeNumberLabel,
            episodeNameLabel
        ])
        stackView.axis = .vertical
        stackView.alignment = .top
        return stackView
    }()

    lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            episodePoster,
            textStack
        ])
        stackView.axis = .horizontal
        stackView.spacing = Constants.stackSpacing / 2
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setConfig()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        setConstraints()
    }

    // MARK: - Config

    private func setConfig() {
        viewSetup()
        setConstraints()
    }

    // MARK: - View SetUp

    private func viewSetup() {
        self.backgroundColor = UIColor(named: Constants.background)
        self.addSubview(mainStack)
    }

    // MARK: - Constraints

    private func setConstraints() {
        episodePoster.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width / 2)
            $0.height.equalTo(UIScreen.main.bounds.height / 2.5)
        }

        episodeNumberLabel.snp.makeConstraints {
            $0.width.lessThanOrEqualToSuperview()
        }

        mainStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.baseInset / 2)
        }
    }

    // MARK: - Layout methods

    func set(episode: EpisodesDetailsResponse) {
        episodeNumberLabel.text = "Episode \(episode.number)"
        episodeNameLabel.text = episode.name
        setImage(image: episodePoster, with: episode.image?.original ?? "")
    }
}
