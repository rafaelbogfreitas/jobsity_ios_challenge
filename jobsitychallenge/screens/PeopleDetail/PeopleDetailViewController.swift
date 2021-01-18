//
//  PeopleDetailViewController.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 17/01/21.
//

import UIKit

class PeopleDetailViewController: UIViewController {
    // MARK: - Variables

    let viewModel = PeopleDetailViewModel()
    let peopleDetalView = PeopleDetailView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }

    // MARK: - View Setup

    private func config() {
        viewSetup()
        setContraints()
    }

    private func viewSetup() {
        self.view.backgroundColor = UIColor(named: Constants.background)
        if let person = self.viewModel.person {
            peopleDetalView.setViewWith(person: person)
        }
        self.view.addSubview(peopleDetalView)
    }

    private func setContraints() {
        peopleDetalView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
