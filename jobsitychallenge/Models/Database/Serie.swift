//
//  Serie.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 16/01/21.
//

import Foundation
import RealmSwift

class Serie: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    let genres = List<String>()
    @objc dynamic var summary = ""
    @objc dynamic var images: SerieImage?
}

class SerieImage: Object {
    @objc dynamic var medium = ""
    @objc dynamic var original = ""
}
