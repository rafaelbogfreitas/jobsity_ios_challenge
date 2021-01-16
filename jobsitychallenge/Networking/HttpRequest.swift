//
//  HttpRequest.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 15/01/21.
//

import Foundation
import Alamofire

class HttpRequest {

    // MARK: - Properties
    typealias OnComplete = (_ response: Data?, _ status: Int) -> Void

    public static var showLogs = true
    public var onComplete: OnComplete?

    // MARK: - Request
    public func request(path: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, onComplete: @escaping OnComplete) -> DataRequest {
        self.onComplete = onComplete

        let request = AF.request(path, method: method, parameters: parameters, encoding: createEncodingWith(method: method), headers: headers).cacheResponse(using: ResponseCacher.cache)

//        if !NetworkManager.instance.connected {
//            self.requestCacheWith(request: request)
//        } else {
//            request.response { (response) in
//                self.handleResponseWith(response: response)
//            }
//        }

        return request
    }

    // MARK: - Encoding
    private func createEncodingWith(method: HTTPMethod) -> ParameterEncoding {
        //Just for post
        var encoding: ParameterEncoding = URLEncoding.default
        if method == .post {
            encoding = JSONEncoding.default
        }
        return encoding
    }

    // MARK: - Cache
    private func requestCacheWith(request: DataRequest) {
        if let urlRequest = request.convertible.urlRequest {
            if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
                self.onComplete?(cachedResponse.data, 200)
            } else {
                self.onComplete?(nil, 599)
            }
        }
    }

    private func addCache(data: Data, to response: AFDataResponse<Data?>) {
        guard let httpResponse = response.response else {return}
        guard let request = response.request else {return}

        //Add response to cache
        let cachedResponse = CachedURLResponse(response: httpResponse, data: data, userInfo: nil, storagePolicy: .allowed)
        Alamofire.Session.default.session.configuration.urlCache?.storeCachedResponse(cachedResponse, for: request)
    }

    public static func clearCaches() {
        Alamofire.Session.default.session.configuration.urlCache?.removeAllCachedResponses()
    }

    // MARK: - Response
    private func handleResponseWith(response: AFDataResponse<Data?>) {
        showLogsFrom(response: response)

        if let error = response.error {
            if error.isExplicitlyCancelledError {
                return
            }
        }

        if let data = response.data {
            addCache(data: data, to: response)
        }

        self.onComplete?(response.data, response.response?.statusCode ?? 0)
    }

    // MARK: - Logs
    private func showLogsFrom(response: AFDataResponse<Data?>) {
        if HttpRequest.showLogs {
            if let requested = response.request {
                if let url = requested.url {
                    print(url.absoluteString)
                }
                if let bodyData = requested.httpBody {
                    print(String(data: bodyData, encoding: .utf8)!)
                }
            }
        }
    }
}
