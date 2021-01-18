//
//  AppearanceUtils.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 16/01/21.
//

import UIKit

class AppearanceUtils {

    public static func getLogoImage() -> UIImageView {

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))

//        imageView.image = UIImage(named: "medcel-top-icon")?.scaledTo(size: imageView.frame.size)?.withRenderingMode(.alwaysTemplate)

        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    public static func setupAppearanceGlobal() {
        applyAppearanceForUITabBar()
        applyAppearanceForUINavigationBar()
//        applySkeletonAppearance()
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
//            UINavigationBar.appearance().isTranslucent = false
//            UINavigationBar.appearance().titleTextAttributes = tileTextAttributes
//            UINavigationBar.appearance().largeTitleTextAttributes = largeTitleTextAttributes
//            UINavigationBar.appearance().shadowImage = UIImage()
//
//            UIBarButtonItem.appearance().setTitleTextAttributes(buttonTextAttributes, for: .normal)
//            UIBarButtonItem.appearance().setTitleTextAttributes(buttonTextAttributes, for: .highlighted)
        }
    }

    public static func applyAppearanceForUITabBar() {
//        UITabBar.appearance().tintColor = UIColor(named: Constants.background)

//        let buttonTextAttributes: [NSAttributedString.Key: NSObject] = [.font: UIFont.defaultRegularFont(ofSize: 11)]
//        UITabBarItem.appearance().setTitleTextAttributes(buttonTextAttributes, for: .normal)
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
