//
//  ApiBase.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 15/01/21.
//

import Foundation
import Alamofire

public class ApiBase {

    var domainPath: String = ""

    var apiMethod: HTTPMethod = HTTPMethod.get
    var apiPath: String = ""
    var appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

    var params = [String: Any]()
    var headers = HTTPHeaders()

    internal var currentRequest: DataRequest?

    init() {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            let nsDictionary = NSDictionary(contentsOfFile: path)
            domainPath = nsDictionary?["SERVER_URL"] as? String ?? ""
        }
    }

    public func request(onComplete: @escaping (_ data: Data?, _ statusCode: Int) -> Void) {
        self.currentRequest = HttpRequest().request(path: self.domainPath + apiPath, method: apiMethod, parameters: params, headers: headers, onComplete: onComplete)
    }

    public func cancelRequest() {
        currentRequest?.cancel()
    }
}
