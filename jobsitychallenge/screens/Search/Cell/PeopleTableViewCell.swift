//
//  PeopleTableViewCell.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 17/01/21.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {

    // MARK: - UI Elements

    lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: Constants.largeFont)
        return label
    }()

    lazy var episodePoster: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit

        return img
    }()

    // MARK: - Stacks

    lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            episodePoster,
            cellLabel
        ])
        stackView.axis = .horizontal
        stackView.spacing = Constants.stackSpacing
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConfig()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Config

    private func setConfig() {
        viewSetup()
        setConstraints()
    }

    // MARK: - View SetUp

    private func viewSetup() {
        self.backgroundColor = UIColor(named: Constants.background)
        self.selectionStyle = .none
        self.backgroundColor = UIColor(named: Constants.background)
        self.addSubview(mainStack)
    }

    // MARK: - Constraints

    private func setConstraints() {
        episodePoster.snp.makeConstraints {
            $0.width.equalTo(frame.width / 2)
        }
        mainStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.baseInset)
        }
    }

    // MARK: - Layout methods

    func set(serie: PeopleSearchResponse) {
        cellLabel.text = serie.person.name
        setImage(image: episodePoster, with: serie.person.image?.medium ?? "")
    }

}
