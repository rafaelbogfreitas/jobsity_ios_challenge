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
    var didPressDeleteButton: (() -> Void)?

    // MARK: - UI Elements

    lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.largeFont)
        label.numberOfLines = 0
        return label
    }()

    lazy var episodePoster: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()

    lazy var favButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(favPressed), for: .touchUpInside)
        button.tintColor = .red
        return button
    }()

    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        button.tintColor = .red
        button.isHidden = true
        button.setImage(UIImage(systemName: "minus.circle"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()

    // MARK: - Stacks

    lazy var contentStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            cellLabel,
            favButton,
            deleteButton
        ])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = Constants.stackSpacing
        return stackView
    }()

    lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            episodePoster,
            contentStack
        ])
        stackView.axis = .horizontal
        stackView.spacing = Constants.stackSpacing
        stackView.alignment = .top
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
        self.selectionStyle = .none
        self.backgroundColor = UIColor(named: Constants.background)
        self.contentView.addSubview(mainStack)
    }

    // MARK: - Constraints

    private func setConstraints() {
        episodePoster.snp.makeConstraints {
            $0.width.equalTo(frame.width / 2)
        }
        mainStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.baseInset)
        }
        favButton.imageView?.snp.makeConstraints {
            $0.size.equalTo(30)
        }
        deleteButton.imageView?.snp.makeConstraints {
            $0.size.equalTo(30)
        }
    }

    // MARK: - Layout methods

    func set(serie: SerieDetailsEntity) {
        cellLabel.text = serie.name
        setImage(image: episodePoster, with: serie.image?.medium ?? "")
        isSelected(value: serie.selected)
    }

    func set(serie: Serie) {
        cellLabel.text = serie.name
        setImage(image: episodePoster, with: serie.images?.medium ?? "")
    }

    public func isSelected(value: Bool) {
        if value {
            favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favButton.setImage(UIImage(systemName: "heart.slash"), for: .normal)
        }
    }

    func deletableCell() {
        favButton.isHidden = true
        deleteButton.isHidden = false
    }

    // MARK: - Actions

    @objc func favPressed(_ sender: UIButton) {
        didPressFavButton?()
    }

    @objc func deletePressed(_ sender: UIButton) {
        didPressDeleteButton?()
    }

}
