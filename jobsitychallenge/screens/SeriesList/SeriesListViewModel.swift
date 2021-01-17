//
//  SeriesListViewModel.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 15/01/21.
//

import Foundation

class SeriesListViewModel {
    var seriesList: [SerieDetailsEntity] = []

    func getMoviesList(onComplete: @escaping (() -> Void)) {
        ApiManager().request(api: ShowsApi.getShowsList(), type: [SerieDataResponse].self) { (series, _) in
            if let series = series {
                self.seriesList = SerieDetailsEntity.mapper(serie: series)
            }
            onComplete()
        }
    }
}
