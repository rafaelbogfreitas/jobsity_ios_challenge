//
//  ShowDataResponse.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 15/01/21.
//

import Foundation

struct SerieDataResponse: Decodable {
    var id: Int
    var name: String
    var genres: [String]
    var schedule: ShowSchedule
    var image: PosterTypes?
    var summary: String?
}

struct ShowSchedule: Decodable {
    var time: String
    var days: [String]
}
