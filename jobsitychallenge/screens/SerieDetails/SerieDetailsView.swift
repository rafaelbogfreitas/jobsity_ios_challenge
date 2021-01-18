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

    lazy var headerView: SerieDetailsHeaderView = {
        let header = SerieDetailsHeaderView()
        return header
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dequeueReusableCell(withIdentifier: Constants.serieDetailsCellIdentifier)
        tableView.backgroundColor = UIColor(named: Constants.background)
        tableView.separatorStyle = .none
        tableView.tableHeaderView = headerView
        return tableView
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = .white
        activity.style = .large
        activity.isHidden = true
        return activity
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
        self.addSubview(activityIndicator)
    }

    // MARK: - Constraints

    private func setContrainsts() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }

        activityIndicator.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }

        headerView.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
    }
}
