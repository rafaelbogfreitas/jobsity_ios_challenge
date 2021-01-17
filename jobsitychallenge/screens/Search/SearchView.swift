//
//  SearchView.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 16/01/21.
//

import UIKit

class SearchView: UIView {

    // MARK: - UI Elements

    lazy var placeholder: EmptyPlaceholder = {
        let placeholder = EmptyPlaceholder()
        return placeholder
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isHidden = true
        tableView.backgroundColor = UIColor(named: Constants.background)
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

    // MARK: - View Setup

    private func config() {
        viewSetup()
        setContraints()
    }

    private func viewSetup() {
        self.addSubview(tableView)
        self.addSubview(placeholder)
        self.addSubview(activityIndicator)
    }

    private func setContraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        placeholder.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        activityIndicator.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
