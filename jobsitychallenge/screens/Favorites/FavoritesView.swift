//
//  FavoritesView.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 17/01/21.
//

import UIKit

class FavoritesView: UIView {

    // MARK: - UI Elements

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dequeueReusableCell(withIdentifier: Constants.serieDetailsCellIdentifier)
        tableView.backgroundColor = UIColor(named: Constants.background)
        tableView.separatorStyle = .none
        return tableView
    }()

    lazy var placeholder: EmptyPlaceholder = {
        let placeholder = EmptyPlaceholder()
        placeholder.messageLabel.text = Constants.favPlaceholderMessage
        return placeholder
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
        self.backgroundColor = UIColor(named: Constants.background)
    }

    private func setContraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        placeholder.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
