//
//  SeriesListTableViewCell.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 15/01/21.
//

import UIKit

class SeriesListTableViewCell: UITableViewCell {

    // MARK: - Variables

    var didPressFavButton: (() -> Void)?

    // MARK: - UI Elements

    lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "\t\t\t"
        return label
    }()

    lazy var episodePoster: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit

        return img
    }()

    lazy var favButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(favPressed), for: .touchUpInside)
        return button
    }()

    // MARK: - Stacks

    lazy var contentStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            cellLabel,
            favButton
        ])
        return stackView
    }()

    lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            episodePoster,
            contentStack
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

    func set(serie: SerieDetailsEntity) {
        cellLabel.text = serie.name
        setImage(image: episodePoster, with: serie.image?.medium ?? "")
    }

    // MARK: - Actions

    @objc func favPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.tintColor = sender.isSelected ? .red : .lightGray
        didPressFavButton?()
    }

}
