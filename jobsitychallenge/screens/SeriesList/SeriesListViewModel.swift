//
//  SeriesListViewModel.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 15/01/21.
//

import Foundation
import RealmSwift

class SeriesListViewModel {
    var seriesList: [SerieDetailsEntity] = []
    var favoritesIds: Results<Favorite>?

    func getMoviesList(onComplete: @escaping (() -> Void)) {
        ApiManager().request(api: ShowsApi.getShowsList(), type: [SerieDataResponse].self) { (series, _) in
            if let series = series {
                self.seriesList = SerieDetailsEntity.mapper(serie: series)
                self.loadFavorites {
                    self.manageSelectedInEntity()
                }
            }
            onComplete()
        }
    }

    func loadFavorites(onComplete: @escaping (() -> Void)) {
        // swiftlint:disable force_try
        let realm = try! Realm()
        favoritesIds = realm.objects(Favorite.self)
        onComplete()
    }

    func manageSelectedInEntity() {
        let realm = try! Realm()
        self.seriesList = seriesList.map { seriesItem in
            if realm.objects(Favorite.self).filter("id == \(seriesItem.id)").first != nil {
                return SerieDetailsEntity(id: seriesItem.id, name: seriesItem.name, genres: seriesItem.genres, schedule: seriesItem.schedule, image: seriesItem.image, summary: seriesItem.summary, selected: true)
            } else {
                return SerieDetailsEntity(id: seriesItem.id, name: seriesItem.name, genres: seriesItem.genres, schedule: seriesItem.schedule, image: seriesItem.image, summary: seriesItem.summary, selected: false)
            }
        }
    }
}
