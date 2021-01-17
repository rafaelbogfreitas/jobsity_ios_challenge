//
//  SerieDetailsViewModel.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 15/01/21.
//

import Foundation

class SerieDetailsViewModel {
    var showId: Int?
    var showName: String?
    var episodes: [EpisodesDetailsResponse] = []
    var seasons: [Int: [EpisodesDetailsResponse]] = [Int(): [EpisodesDetailsResponse]()]

    // MARK: - Intents

    func getEpisodesByShowId(onComplete: @escaping (() -> Void)) {
        if let id = showId {
            ApiManager().request(api: ApiEpisodes.getEpisodesByShowId(with: id), type: [EpisodesDetailsResponse].self) { (episodes, success) in
                if let episodes = episodes, success {
                    self.episodes = episodes
                    self.separateEpisodeIntoSeasons()
                }
                onComplete()
            }
        }
    }

    // MARK: - Methods

    /**
     Method to create separate data structures for each season in a serie
     
     This function iterates over the *episodes* array, checking the season number of every item to update the *seasons* dictionary. If a key with the same number as the current episode's season number is found, the item is appended to the same array value, else it creates another key in the dictionary.

     */

    private func separateEpisodeIntoSeasons() {
        episodes.forEach {
            if seasons[$0.season - 1] != nil {
                seasons[$0.season - 1]?.append($0)
            } else {
                seasons[$0.season - 1] = [$0]
            }
        }
    }

}
