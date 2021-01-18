//
//  SerieDetailsHeaderView.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 17/01/21.
//

import UIKit

class SerieDetailsHeaderView: UIView {

    // MARK: - UI Elements

    lazy var serieNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.xlargeFont)
        label.numberOfLines = 0
        return label
    }()

    lazy var posterImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    lazy var airDateAndTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.mediumFont, weight: .light)
        label.numberOfLines = 0
        return label
    }()

    lazy var genresLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.mediumFont, weight: .light)
        label.numberOfLines = 0
        return label
    }()

    lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.mediumFont)
        label.textAlignment = .justified
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Stacks

    lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            serieNameLabel,
            genresLabel,
            posterImage,
            summaryLabel,
            airDateAndTimeLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = Constants.stackSpacing / 2
        stackView.alignment = .center
        return stackView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Setup

    private func config() {
        viewSetup()
        setContraints()
    }

    private func viewSetup() {
        self.addSubview(mainStack)
    }

    private func setContraints() {
        mainStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.baseInset)
        }
    }

    // MARK: - Methods

    func setViewWith(serie: SerieDetailsEntity) {
        serieNameLabel.text = serie.name
        genresLabel.text = formatGenresStringArray(serie.genres)
        self.setImage(image: posterImage, with: serie.image?.medium ?? "")
        summaryLabel.text = serie.summary?.html2String ?? ""
        airDateAndTimeLabel.text = formatSerieSchedule(schedule: serie.schedule)
    }

    private func formatGenresStringArray(_ genres: [String]) -> String {
        var string = ""

        genres.forEach {
            string = "\($0), \(string)"
        }

        return string
    }

    private func formatSerieSchedule(schedule: SerieDetailsEntity.ShowSchedule? = nil) -> String {
        var string = ""
        if let schedule = schedule {
            string = "At \(string)\(schedule.time)\non "
            schedule.days.forEach {
                string = "\(string) \($0),"
            }
        } else {
            string = "No dates and time available"
        }
        return string
    }
}
