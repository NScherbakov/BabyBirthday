//
//  WelcomeViewRouter.swift
//  BabyBirthday
//
//  Created by Nikolay on 9/22/20.
//  Copyright © 2020 Nikolay. All rights reserved.
//

import Foundation

protocol WelcomeRouterDelegate: class {
    func showBirthday()
}

final class WelcomeRouter {
    private weak var delegate: WelcomeRouterDelegate?

    init(coordinator: WelcomeRouterDelegate) {
        self.delegate = coordinator
    }

    func build() -> WelcomeViewController {
        let viewController = WelcomeViewController.storyboardViewController() as WelcomeViewController
        let presenter = WelcomePresenter(router: self)

        viewController.presenter = presenter
        presenter.view = viewController

        return viewController
    }
    
    func showBirthday() {
        delegate?.showBirthday()
    }
}
