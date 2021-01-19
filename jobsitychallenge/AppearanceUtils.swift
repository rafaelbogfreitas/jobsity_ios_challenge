//
//  AppearanceUtils.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 16/01/21.
//

import UIKit

class AppearanceUtils {

    public static func setupAppearanceGlobal() {
        applyAppearanceForUITabBar()
        applyAppearanceForUINavigationBar()
    }

    public static func applyAppearanceForUINavigationBar() {
        UINavigationBar.appearance().tintColor = UIColor(named: Constants.navTint)
        UINavigationBar.appearance().barStyle = .black

        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = UIColor(named: "Color_Navigation")
            navBarAppearance.shadowColor = .clear

            let buttonAppearance = UIBarButtonItemAppearance()
            navBarAppearance.buttonAppearance = buttonAppearance
            navBarAppearance.backButtonAppearance = buttonAppearance

            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance

        } else {
            UINavigationBar.appearance().backgroundColor = UIColor(named: "Color_Navigation")
            UINavigationBar.appearance().barTintColor = UIColor(named: Constants.background)
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().shadowImage = UIImage()
        }
    }

    public static func applyAppearanceForUITabBar() {
        UITabBar.appearance().tintColor = UIColor(named: Constants.background)
    }

}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return  .lightContent
    }
}

extension UINavigationBar {
    func makeTransparent() {
        if #available(iOS 13, *) {
            self.standardAppearance.configureWithTransparentBackground()
        } else {
            self.setBackgroundImage(UIImage(), for: .default)
            self.isTranslucent = true
            self.backgroundColor = .clear
        }
    }

    func makeOpaque() {
        if #available(iOS 13, *) {
            self.standardAppearance.configureWithOpaqueBackground()
            self.standardAppearance.backgroundColor = UIColor(named: "Color_Background")
        } else {
            self.setBackgroundImage(nil, for: .default)
            self.isTranslucent = false
            self.backgroundColor = UIColor(named: "Color_Background")
            self.barTintColor = UIColor(named: "Color_Background")
        }
    }

    func makeTransparentWithBlur() {
        if #available(iOS 13.0, *) {
            self.standardAppearance.configureWithDefaultBackground()
        } else {
            self.setBackgroundImage(nil, for: .default)
            self.isTranslucent = true
            self.backgroundColor = nil
            self.barTintColor = nil
        }
    }
}
