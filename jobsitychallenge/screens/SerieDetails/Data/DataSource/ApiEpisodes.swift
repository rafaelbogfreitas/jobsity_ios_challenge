//
//  ApiEpisodes.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 15/01/21.
//

import Foundation

class ApiEpisodes: ApiBase {
    static func getEpisodesByShowId(with showId: Int) -> ApiBase {
        let api = ApiBase()
        api.apiPath = "shows/\(showId)/episodes"
        api.apiMethod = .get
        return api
    }
}
