//
//  SerieDetailTableViewCell.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 15/01/21.
//

import UIKit
import SkeletonView

class SerieDetailsTableViewCell: UITableViewCell {

    // MARK: - UI Elements

    lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.text = "\t\t\t"
        return label
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
        self.isSkeletonable = true
        self.contentView.addSubview(cellLabel)
    }

    // MARK: - Constraints

    private func setConstraints() {
        cellLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Layout methods

    func set(name: String, number: Int) {
        cellLabel.text = "\(number) - \(name)"
    }

}
