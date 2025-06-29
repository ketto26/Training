//
//  TabBarController.swift
//  MultiTabApp
//
//  Created by Keto Nioradze on 29.06.25.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupTabBarAppearance()
    }

    private func setupViewControllers() {
        let onboardingVC = OnboardingViewController()
        let onboardingNavVC = UINavigationController(rootViewController: onboardingVC)
        onboardingNavVC.tabBarItem = UITabBarItem(
            title: "Onboarding",
            image: UIImage(systemName: "hand.raised.fill"),
            selectedImage: UIImage(systemName: "hand.raised.fill")
        )

        let profileVC = ProfileViewController()
        let profileNavVC = UINavigationController(rootViewController: profileVC)
        profileNavVC.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.fill"),
            selectedImage: UIImage(systemName: "person.fill")
        )

        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape.fill"),
            selectedImage: UIImage(systemName: "gearshape.fill")
        )

        viewControllers = [onboardingNavVC, profileNavVC, settingsVC]
    }

    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .orange

        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.stackedLayoutAppearance.selected.iconColor = .white

        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        appearance.stackedLayoutAppearance.normal.iconColor = .gray

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance

        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray 
    }
}
