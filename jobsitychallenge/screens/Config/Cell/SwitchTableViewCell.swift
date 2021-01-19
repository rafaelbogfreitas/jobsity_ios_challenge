//
//  SwitchTableViewCell.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 18/01/21.
//

import UIKit

class UISwitchTableViewCell: UITableViewCell {

    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.mediumFont)
        return label
    }()

    public var switcher: UISwitch = UISwitch()

    public var didChangeSwitchValue:(() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        backgroundColor = UIColor(named: Constants.background)
        selectionStyle = .none

        accessoryView = switcher

        switcher.isOn = UserDefaults.standard.bool(forKey: "hasPassword")
        switcher.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)

        self.contentView.addSubview(titleLabel)
    }

    private func setContraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(20)
        }
    }

    // MARK: - Actions

    @objc private func handleSwitchAction() {
        didChangeSwitchValue?()
    }

}
