//
//  SearchViewModel.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 16/01/21.
//

import Foundation

class SearchViewModel {
    var series: [SeriesSearchResponse] = []

    func searchSeries(with string: String, onComplete: @escaping (() -> Void)) {
        ApiManager().request(api: ApiSearch.searchSeries(with: string), type: [SeriesSearchResponse].self) { (series, success) in
            if let series = series, success {
                self.series = series
            }
            onComplete()
        }
    }
}
