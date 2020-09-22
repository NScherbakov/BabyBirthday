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

extension AppCoordinator: WelcomeRouterDelegate {}

