//
//  SerieDetailsEntity.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 17/01/21.
//

import Foundation

struct SerieDetailsEntity {
    var id: Int
    var name: String
    var genres: [String]
    var schedule: ShowSchedule? = ShowSchedule(time: "", days: [])
    var image: PosterTypes? = PosterTypes(medium: "", original: "")
    var summary: String? = ""
    var selected: Bool = false

    struct ShowSchedule {
        var time: String
        var days: [String]
    }

    static func mapper(serie: [SerieDataResponse]) -> [SerieDetailsEntity] {
        serie.map {
            let schedule = ShowSchedule(time: $0.schedule.time, days: $0.schedule.days)

            return SerieDetailsEntity(id: $0.id, name: $0.name, genres: $0.genres, schedule: schedule, image: $0.image, summary: $0.summary)
        }
    }

    static func mapper(searchSeries: [SeriesSearchResponse]) -> [SerieDetailsEntity] {
        searchSeries.map {
            let schedule = ShowSchedule(time: $0.show.schedule.time, days: $0.show.schedule.days)

            return SerieDetailsEntity(id: $0.show.id, name: $0.show.name, genres: $0.show.genres, schedule: schedule, image: $0.show.image, summary: $0.show.summary)
        }
    }

    static func convert(realmSerie: Serie) -> SerieDetailsEntity {

//        let schedule = ShowSchedule(
//            time: realmSerie.schedule?.time,
//            days: realmSerie.schedule?.days
//        )

        let image = PosterTypes(
            medium: realmSerie.images?.medium ?? "",
            original: realmSerie.images?.original ?? ""
        )

        return SerieDetailsEntity(
            id: realmSerie.id,
            name: realmSerie.name,
            genres: realmSerie.genres.map { $0 },
//            schedule: schedule,
            image: image,
            summary: realmSerie.summary
        )
    }

}
