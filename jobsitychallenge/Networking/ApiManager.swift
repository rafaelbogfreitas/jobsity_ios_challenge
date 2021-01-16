//
//  NetworkManager.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 15/01/21.
//

import Foundation

struct ApiManager {

    func request(api: ApiBase, onComplete: ((Bool) -> Void)? = nil) {
        api.request { (_, statusCode) in
            onComplete?(statusCode == 200)
        }
    }

    func request<T: Decodable>(api: ApiBase, type: T.Type? = nil, onComplete: ((T?, Bool) -> Void)? = nil) {
        api.request { (data, _) in
            do {
                if let data = data {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    onComplete?(model, true)
                    return
                }
            } catch {
                print(error)
            }
            onComplete?(nil, false)
        }
    }

}
