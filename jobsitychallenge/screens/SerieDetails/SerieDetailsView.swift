//
//  SerieDetailsView.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 15/01/21.
//

import UIKit
import SnapKit

class SerieDetailsView: UIView {

    // MARK: - UIElements
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dequeueReusableCell(withIdentifier: Constants.serieDetailsCellIdentifier)
        return tableView
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
        setUpView()
        setContrainsts()
    }

    // MARK: - View Setup

    private func setUpView() {
        self.addSubview(tableView)
    }

    // MARK: - Constraints

    private func setContrainsts() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
