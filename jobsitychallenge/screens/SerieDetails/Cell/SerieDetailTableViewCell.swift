//
//  SerieDetailTableViewCell.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 15/01/21.
//

import UIKit
import SkeletonView
import Kingfisher

class SerieDetailsTableViewCell: UITableViewCell {

    // MARK: - UI Elements

    lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.numberOfLines = 0
        label.text = "\t\t\t"
        return label
    }()

    lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.numberOfLines = 0
        label.text = "\t\t\t"
        return label
    }()

    lazy var episodePoster: UIImageView = {
        let img = UIImageView()
        img.isSkeletonable = true
        img.contentMode = .scaleAspectFit

        return img
    }()

    // MARK: - Stacks

    lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            episodePoster,
            cellLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = Constants.stackSpacing
        stackView.isSkeletonable = true
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.isSkeletonable = true
        setConfig()
        layoutSubviews()
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
        self.isSkeletonable = true
        self.backgroundColor = UIColor(named: Constants.background)
        self.addSubview(mainStack)
    }

    // MARK: - Constraints

    private func setConstraints() {
        episodePoster.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(UIScreen.main.bounds.width / 2)
        }
        mainStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.baseInset)
        }
    }

    // MARK: - Layout methods

    func set(episode: EpisodesDetailsResponse) {
        cellLabel.text = "\(episode.number) - \(episode.name)"
        summaryLabel.text = episode.summary?.html2String
        setImage(image: episodePoster, with: episode.image?.original ?? "")
    }
}
