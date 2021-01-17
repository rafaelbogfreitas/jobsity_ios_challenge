//
//  SearchViewModel.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 16/01/21.
//

import Foundation

class SearchViewModel {
    var series: [SeriesSearchResponse] = []
    var people: [PeopleSearchResponse] = []

    func searchSeries(with string: String, onComplete: @escaping (() -> Void)) {
        ApiManager().request(api: ApiSearch.searchSeries(with: string), type: [SeriesSearchResponse].self) { (series, success) in
            if let series = series, success {
                self.series = series
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
}
