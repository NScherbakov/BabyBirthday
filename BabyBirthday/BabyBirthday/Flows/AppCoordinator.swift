//
//  AppCoordinator.swift
//  BabyBirthday
//
//  Created by Nikolay on 9/22/20.
//  Copyright © 2020 Nikolay. All rights reserved.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let navigation: UINavigationController
    private var birthdayVC: BirthdayViewController?

    init(window: UIWindow) {
        self.window = window
        self.navigation = UINavigationController()
        self.window.rootViewController = navigation
    }

    func start() {
        let router = WelcomeRouter(coordinator: self)
        let viewController = router.build()
        navigation.setViewControllers([viewController], animated: false)
    }
}

extension AppCoordinator: WelcomeRouterDelegate {
    func showBirthday() {
        let router = BirthdayRouter(coordinator: self)
        birthdayVC = router.build()
        birthdayVC?.modalPresentationStyle = .fullScreen
        navigation.present(birthdayVC!, animated: true)
    }
}

extension AppCoordinator: BirthdayRouterDelegate {
    func dismiss() {
        birthdayVC?.dismiss(animated: true)
    }
}

