//
//  FavoritesViewModel.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 17/01/21.
//

import Foundation
import RealmSwift

class FavoritesViewModel {
    var favorites: Results<Serie>?

    func loadFavorites(onComplete: @escaping (() -> Void)) {
        // swiftlint:disable force_try
        let realm = try! Realm()
        self.favorites = realm.objects(Serie.self).sorted(byKeyPath: "name", ascending: true)
        onComplete()
    }
}
