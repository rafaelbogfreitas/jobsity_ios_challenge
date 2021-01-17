//
//  SeriesListView.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 16/01/21.
//

import UIKit

class SeriesListView: UIView {

    // MARK: - UI Elements

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = .white
        activity.style = .large
        activity.isHidden = true
        return activity
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: Constants.seriesListCellIdentifier
        )
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: Constants.background)
        tableView.isHidden = true
        return tableView
    }()

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
        self.addSubview(activityIndicator)
        self.addSubview(tableView)
    }

    private func setContraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        activityIndicator.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
