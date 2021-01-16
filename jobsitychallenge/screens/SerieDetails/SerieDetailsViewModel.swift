//
//  SerieDetailsViewModel.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 15/01/21.
//

import Foundation

class SerieDetailsViewModel {
    var showId: Int?
    var episodes: [EpisodesDetailsResponse] = []

    func getEpisodesByShowId(onComplete: @escaping (() -> Void)) {
        if let id = showId {
            ApiManager().request(api: ApiEpisodes.getEpisodesByShowId(with: id), type: [EpisodesDetailsResponse].self) { (episodes, success) in
                if let episodes = episodes, success {
                    self.episodes = episodes
                }
                onComplete()
            }
        }
    }
}
