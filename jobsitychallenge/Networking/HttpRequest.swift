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

        request.response { (response) in
            self.handleResponseWith(response: response)
        }

        return request
    }

    // MARK: - Encoding
    private func createEncodingWith(method: HTTPMethod) -> ParameterEncoding {
        // Just for post
        var encoding: ParameterEncoding = URLEncoding.default
        if method == .post {
            encoding = JSONEncoding.default
        }
        return encoding
    }

    // MARK: - Response
    private func handleResponseWith(response: AFDataResponse<Data?>) {
        showLogsFrom(response: response)

        if let error = response.error {
            if error.isExplicitlyCancelledError {
                return
            }
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
