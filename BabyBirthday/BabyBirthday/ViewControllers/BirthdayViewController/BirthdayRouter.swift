//
//  BirthdayRouter.swift
//  BabyBirthday
//
//  Created by Nikolay on 9/24/20.
//  Copyright © 2020 Nikolay. All rights reserved.
//

import Foundation

protocol BirthdayRouterDelegate: class {}

final class BirthdayRouter {
    private weak var delegate: BirthdayRouterDelegate?

    init(coordinator: BirthdayRouterDelegate) {
        self.delegate = coordinator
    }

    func build() -> BirthdayViewController {
        let viewController = BirthdayViewController.storyboardViewController() as BirthdayViewController
        let presenter = BirthdayPresenter(router: self)

        viewController.presenter = presenter
        presenter.view = viewController

        return viewController
    }
}
