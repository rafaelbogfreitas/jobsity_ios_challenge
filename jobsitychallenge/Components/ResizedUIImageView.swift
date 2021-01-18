//
//  ResizedUIImageView.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 17/01/21.
//

import UIKit

class ResizedUIImageView: UIImageView {

  override var image: UIImage? {
    didSet {
      guard let image = image else { return }

      let resizeConstraints = [
        self.heightAnchor.constraint(equalToConstant: image.size.height * 10),
        self.widthAnchor.constraint(equalToConstant: image.size.width * 10)
      ]

      if superview != nil {
        addConstraints(resizeConstraints)
      }
    }
  }
}
