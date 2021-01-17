//
//  ApiSearch.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 16/01/21.
//

import Foundation

class ApiSearch: ApiBase {
    static func searchSeries(with string: String) -> ApiBase {
        let api = ApiBase()
        api.apiMethod = .get
        api.apiPath = "/search/shows?q=\(string)"
        return api
    }
}
