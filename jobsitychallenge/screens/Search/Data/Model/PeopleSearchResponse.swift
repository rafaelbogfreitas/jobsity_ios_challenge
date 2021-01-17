//
//  PeopleSearchResponse.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 17/01/21.
//

import Foundation

struct PeopleSearchResponse: Decodable {
    var score: Float
    var person: Person
}

struct Person: Decodable {
    var id: Int
    var url: String
    var name: String
    var country: Country?
    var birthday: String?
    var deathday: String?
    var gender: String?
    var image: PosterTypes?
}

struct Country: Decodable {
    var name: String
    var code: String
    var timezone: String
}
