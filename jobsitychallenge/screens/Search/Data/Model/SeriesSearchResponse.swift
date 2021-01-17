//
//  SeriesSearchResponse.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 16/01/21.
//

import Foundation

struct SeriesSearchResponse: Decodable {
    var score: Float
    var show: ShowDataResponse
}
