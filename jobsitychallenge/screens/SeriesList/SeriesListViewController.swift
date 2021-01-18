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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.loadFavorites {
            self.viewModel.manageSelectedInEntity()
            self.seriesListView.tableView.reloadData()
        }
    }

    // MARK: - View Setup

    private func config() {
        viewSetup()
        navigationSetup()
        setContraints()
    }

    private func viewSetup() {
        self.view.backgroundColor = UIColor(named: Constants.background)
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

        self.title = "Series"
        let magnifyingGlass = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass" ), style: .plain, target: self, action: #selector(searchButtonPressed))
        let gearShape = UIBarButtonItem(image: UIImage(systemName: "gearshape" ), style: .plain, target: self, action: #selector(searchButtonPressed))

        navigationItem.rightBarButtonItems = [gearShape, magnifyingGlass]
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

    private func saveSerieAndIdToRealm(serie currentSerie: SerieDetailsEntity) {
        let serieId = Favorite()
        serieId.id = currentSerie.id

        let serie = Serie()
        let serieImage = SerieImage()
        serieImage.medium = currentSerie.image?.medium ?? ""
        serieImage.original = currentSerie.image?.original ?? ""

        serie.genres.append(objectsIn: currentSerie.genres)
        serie.id = currentSerie.id
        serie.name = currentSerie.name
        serie.summary = currentSerie.summary ?? ""
        serie.images = serieImage

        do {
            try self.realm.write {
                self.realm.add(serieId)
                self.realm.add(serie)
            }
        } catch {
            print("Failed saving serie id in Realm")
            print("Error: \(error)")
        }
    }

    private func deleteSerieAndIdFromRealm(serie currentSerie: SerieDetailsEntity) {
        let serieIdToBeDeleted = self.realm.objects(Favorite.self).filter("id == \(currentSerie.id)").first
        let serieToBeDeleted = self.realm.objects(Serie.self).filter("id == \(currentSerie.id)").first
        let imageToDelete = serieToBeDeleted?.images

        do {
            try self.realm.write {
                self.realm.delete(serieIdToBeDeleted!)
                self.realm.delete(serieToBeDeleted!)
                self.realm.delete(imageToDelete!)
            }
        } catch {
            print("Failed deleting serie id in Realm")
            print("Error: \(error)")
        }
    }
}

extension SeriesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.seriesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = self.seriesListView.tableView.dequeueReusableCell(
            withIdentifier: Constants.seriesListCellIdentifier
        ) as? SeriesListTableViewCell ?? SeriesListTableViewCell()

        cell.set(serie: self.viewModel.seriesList[indexPath.row])

        cell.didPressFavButton = {

            self.viewModel.seriesList[indexPath.row].selected = !self.viewModel.seriesList[indexPath.row].selected

            if self.viewModel.seriesList[indexPath.row].selected {
                self.saveSerieAndIdToRealm(serie: self.viewModel.seriesList[indexPath.row])
            } else {
                self.deleteSerieAndIdFromRealm(serie: self.viewModel.seriesList[indexPath.row])
            }
            cell.set(serie: self.viewModel.seriesList[indexPath.row])
        }

        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentSerie = self.viewModel.seriesList[indexPath.row]
        let serieDetails = SerieDetailsViewController()
        serieDetails.viewModel.show = currentSerie
        self.navigationController?.pushViewController(serieDetails, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}
