//
//  Extensions.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 16/01/21.
//

import UIKit

// MARK: UINavigationController
extension UINavigationController {
    public func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        pushViewController(viewController, animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            completion?()
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion?() }
    }
}
