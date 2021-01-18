//
//  SearchViewModel.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 16/01/21.
//

import Foundation
import RealmSwift

class SearchViewModel {
    var series: [SerieDetailsEntity] = []
    var favoritesIds: Results<Favorite>?
    var people: [PeopleSearchResponse] = []

    func searchSeries(with string: String, onComplete: @escaping (() -> Void)) {
        ApiManager().request(api: ApiSearch.searchSeries(with: string), type: [SeriesSearchResponse].self) { (series, success) in
            if let series = series, success {
                self.series = SerieDetailsEntity.mapper(searchSeries: series)
                self.manageSelectedInEntity()
            }
            onComplete()
        }
    }

    func searchPeople(with string: String, onComplete: @escaping (() -> Void)) {
        ApiManager().request(api: ApiSearch.searchPeople(with: string), type: [PeopleSearchResponse].self) { (people, success) in
            if let people = people, success {
                self.people = people
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
        self.series = series.map { seriesItem in
            if realm.objects(Favorite.self).filter("id == \(seriesItem.id)").first != nil {
                return SerieDetailsEntity(id: seriesItem.id, name: seriesItem.name, genres: seriesItem.genres, schedule: seriesItem.schedule, image: seriesItem.image, summary: seriesItem.summary, selected: true)
            } else {
                return SerieDetailsEntity(id: seriesItem.id, name: seriesItem.name, genres: seriesItem.genres, schedule: seriesItem.schedule, image: seriesItem.image, summary: seriesItem.summary, selected: false)
            }
        }
    }
}
