//
//  EpisodeDetailsView.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 16/01/21.
//

import UIKit

class EpisodeDetailsView: UIView {

    // MARK: - UI Elements

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(mainStack)
        return scrollView
    }()

    lazy var episodeName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.largeFont)
        return label
    }()

    lazy var posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var episodeInfo: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.mediumFont, weight: .light)
        return label
    }()

    lazy var summary: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: Constants.mediumFont, weight: .regular)
        return label
    }()

    // MARK: - Stacks

    lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            episodeName,
            episodeInfo,
            posterImage,
            summary
        ])
        stackView.axis = .vertical
        stackView.spacing = Constants.stackSpacing
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        config()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Config

    private func config() {
        viewSetup()
        setConstraints()
    }

    // MARK: - View SetUp

    private func viewSetup() {
        self.addSubview(scrollView)
    }

    // MARK: - Constraints

    private func setConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }

        mainStack.snp.makeConstraints {
            $0.top.width.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview().inset(20)
        }

        posterImage.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
        }
    }

    // MARK: - Methods

    func set(episode: EpisodesDetailsResponse) {
        setImage(with: episode.image?.medium ?? "")
        setEpisodeSubtitleInfo(with: episode.number, in: episode.season)
        summary.text = episode.summary?.html2String
        episodeName.text = episode.name
    }

    private func setImage(with url: String) {
        let httpsUrl = url.replacingOccurrences(of: "http", with: "https")
        if let url = URL(string: httpsUrl) {
            DispatchQueue.main.async {[weak self] in
                guard let self = self else {return}
                self.posterImage.kf.setImage(with: url, placeholder: UIImage(systemName: "film"))
            }
        }
    }

    func setEpisodeSubtitleInfo(with episode: Int, in season: Int) {
        episodeInfo.text = "Episode \(episode) • Season \(season)"
    }

}
