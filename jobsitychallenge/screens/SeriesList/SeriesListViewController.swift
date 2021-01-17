//
//  ViewController.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 14/01/21.
//

import UIKit
import RealmSwift

class SeriesListViewController: UIViewController {

    // MARK: - Variables

    let seriesListView = SeriesListView()
    let viewModel = SeriesListViewModel()

    // swiftlint:disable force_try
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        startActivityIndicator()

        self.viewModel.getMoviesList {[weak self] in
            self?.stopActivityIndicator()
            self?.seriesListView.tableView.reloadData()
        }

        config()
    }

    // MARK: - View Setup

    private func config() {
        viewSetup()
        navigationSetup()
        setContraints()
    }

    private func viewSetup() {
        self.seriesListView.tableView.delegate = self
        self.seriesListView.tableView.dataSource = self
        self.view.addSubview(seriesListView)
    }

    private func setContraints() {
        seriesListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Navigation Setup

    private func navigationSetup() {

        self.title = "Jobsity series"
        let magnifyingGlass = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass" ), style: .plain, target: self, action: #selector(searchButtonPressed))
        let gearShape = UIBarButtonItem(image: UIImage(systemName: "gearshape" ), style: .plain, target: self, action: #selector(searchButtonPressed))

        navigationItem.rightBarButtonItems = [magnifyingGlass, gearShape]
    }

    // MARK: - Actions

    @objc private func searchButtonPressed() {
        let searchViewController = SearchViewController()
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }

    @objc private func configButtonPressed() {
        print("🤬")
    }

    // MARK: - Methods

    private func startActivityIndicator() {
        seriesListView.activityIndicator.startAnimating()
        seriesListView.activityIndicator.isHidden = false
        seriesListView.tableView.isHidden = true
    }

    private func stopActivityIndicator() {
        seriesListView.activityIndicator.stopAnimating()
        seriesListView.activityIndicator.isHidden = true
        seriesListView.tableView.isHidden = false
    }
}

extension SeriesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.seriesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSerie = viewModel.seriesList[indexPath.row]
        let cell = self.seriesListView.tableView.dequeueReusableCell(
            withIdentifier: Constants.seriesListCellIdentifier
        ) as? SeriesListTableViewCell ?? SeriesListTableViewCell()
        cell.set(serie: currentSerie)
        cell.didPressFavButton = {
            if cell.favButton.isSelected {
//                let serie = Serie()
//                serie.id = currentSerie.id
//                serie.name = currentSerie.name
//                serie.summary = currentSerie.summary ?? ""
//                serie.genres.append(objectsIn: currentSerie.genres)
//                
//                do {
//                    try self.realm.write {
//                        self.realm.add(serie)
//                    }
//                } catch {
//                    print("Failed saving serie to realm. Error: \(error)")
//                }

            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentSerie = self.viewModel.seriesList[indexPath.row]
        let serieDetails = SerieDetailsViewController()
        serieDetails.viewModel.showId = currentSerie.id
        serieDetails.viewModel.showName = currentSerie.name
        self.navigationController?.pushViewController(serieDetails, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}
