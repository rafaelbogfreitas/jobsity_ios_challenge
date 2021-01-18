//
//  PeopleDetailView.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 17/01/21.
//

import UIKit

class PeopleDetailView: UIView {

    // MARK: - UI Elements

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(mainStackView)
        return scrollView
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.xlargeFont)
        return label
    }()

    lazy var posterImage: ResizedUIImageView = {
        let image = ResizedUIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            posterImage
        ])
        stackView.axis = .vertical
        stackView.spacing = Constants.stackSpacing
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
        self.backgroundColor = UIColor(named: Constants.background)
        self.addSubview(scrollView)
    }

    private func setContraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }

        mainStackView.snp.makeConstraints {
            $0.top.width.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview().inset(20)
        }
    }

    // MARK: - Methods

    func setViewWith(person: PeopleSearchResponse) {
        nameLabel.text = person.person.name
        self.setImage(image: posterImage, with: person.person.image?.original ?? "")
    }
}
