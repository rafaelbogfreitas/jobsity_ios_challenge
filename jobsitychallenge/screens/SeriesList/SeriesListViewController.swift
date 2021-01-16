//
//  ViewController.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 14/01/21.
//

import UIKit

class SeriesListViewController: UITableViewController {
    let viewModel = SeriesListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: Constants.seriesListCellIdentifier
        )

        self.viewModel.getMoviesList {
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.seriesList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(
            withIdentifier: Constants.seriesListCellIdentifier
        ) as? SeriesListTableViewCell ?? SeriesListTableViewCell()
        cell.textLabel?.text = viewModel.seriesList[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Chosen🤗")
    }
}
