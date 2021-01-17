//
//  Extensions.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 16/01/21.
//

import UIKit

// MARK: - TableViewCell

extension UIView {
    func setImage(image: UIImageView, with url: String) {
        let httpsUrl = url.replacingOccurrences(of: "http", with: "https")
        if let url = URL(string: httpsUrl) {
            DispatchQueue.main.async {
                image.kf.setImage(
                    with: url,
                    placeholder: UIImage(systemName: "hourglass")
                )
            }
        } else {
            image.image = UIImage(systemName: "film")
        }
    }
}

// MARK: - Data

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}

// MARK: - StringProtocol

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
