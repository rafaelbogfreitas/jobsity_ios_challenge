//
//  TabViewController.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 16/01/21.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.barStyle = .black

        modalPresentationStyle = .fullScreen

        // MARK: - Series List
        let seriesListController = SeriesListViewController()
        let seriesListNavController = UINavigationController(rootViewController: seriesListController)
        seriesListNavController.tabBarItem = UITabBarItem(title: "Series", image: UIImage(systemName: "film"), tag: 0)

        let searchViewController = SearchViewController(isPeopleSearch: true)
        let searchNavController = UINavigationController(rootViewController: searchViewController)
        searchNavController.tabBarItem = UITabBarItem(title: "People", image: UIImage(systemName: "person.2"), tag: 1)

        self.viewControllers = [seriesListNavController, searchNavController]

    }
}
