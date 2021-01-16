//
//  EpisodesDetailsResponse.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 15/01/21.
//

import Foundation

struct EpisodesDetailsResponse: Decodable {
    var id: Int
    var url: String
    var name: String
    var season: Int
    var image: PosterTypes
    var summary: String
    var type: String
    var airdate: String
    var airtime: String
    var airstamp: String
    var runtime: Int
}
