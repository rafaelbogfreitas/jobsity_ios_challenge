//
//  FavoritesViewController.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 17/01/21.
//

import UIKit
import RealmSwift

class FavoritesViewController: UIViewController {
    // MARK: - Variables

    let viewModel = FavoritesViewModel()
    let favoritesView = FavoritesView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.favoritesView.tableView.reloadData()
        self.managePlaceholder()
    }

    // MARK: - View Setup

    private func config() {
        viewSetup()
        navigationSetup()
        setContraints()
    }

    private func viewSetup() {
        self.view.addSubview(favoritesView)
        self.view.backgroundColor = UIColor(named: Constants.background)
        self.favoritesView.tableView.delegate = self
        self.favoritesView.tableView.dataSource = self

        self.viewModel.loadFavorites {
            self.favoritesView.tableView.reloadData()
            self.managePlaceholder()
        }
    }

    // MARK: - Navigation SetUp

    private func navigationSetup() {
        self.navigationItem.title = "Favorites"
    }

    // MARK: - Constraints

    private func setContraints() {
        favoritesView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Methods

    private func deleteFromRealm(favorite: Serie) {
        // swiftlint:disable force_try
        let realm = try! Realm()
        let favToBeDeleted = realm.objects(Serie.self).filter("id == \(favorite.id)").first
        let imageToDelete = favToBeDeleted?.images
        let favIdToBeDeleted = realm.objects(Favorite.self).filter("id == \(favorite.id)").first
        do {
            try realm.write {
                realm.delete(favIdToBeDeleted!)
                realm.delete(favToBeDeleted!)
                realm.delete(imageToDelete!)

            }
        } catch {
            print("Failed trying to delete a favorite from Realm")
            print("Error: \(error)")
        }
    }

    private func managePlaceholder() {
        if let favs = self.viewModel.favorites {
            self.favoritesView.placeholder.isHidden = !favs.isEmpty
            self.favoritesView.tableView.isHidden = favs.isEmpty
        }
    }

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.favorites?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.favoritesView.tableView.dequeueReusableCell(withIdentifier: Constants.serieDetailsCellIdentifier) as? SeriesListTableViewCell ?? SeriesListTableViewCell()
        if let currentFav = self.viewModel.favorites?[indexPath.row] {
            cell.set(serie: currentFav)
            cell.deletableCell()

            cell.didPressDeleteButton = {
                self.deleteFromRealm(favorite: currentFav)
                self.favoritesView.tableView.reloadData()
                self.managePlaceholder()
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: - Navigate to Detail
//        if let curretFav = self.viewModel.favorites?[indexPath.row] {
//            let serieDetails = SerieDetailsViewController()
//            serieDetails.viewModel.show = currentSerie
//            self.navigationController?.pushViewController(serieDetails, animated: true)
//        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }

}
