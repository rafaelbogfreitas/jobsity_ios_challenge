//
//  ShowsApi.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 15/01/21.
//

import Foundation

class ShowsApi: ApiBase {
    static func getShowsList() -> ApiBase {
        let api = ApiBase()
        api.apiMethod = .get
        api.apiPath = "shows"
        return api
    }
}
