//
//  BirthdayPresenter.swift
//  BabyBirthday
//
//  Created by Nikolay on 9/24/20.
//  Copyright © 2020 Nikolay. All rights reserved.
//

import UIKit

final class BirthdayPresenter {
    weak var view: BirthdayViewInput?
    
    // MARK: - Private
    
    private let currentPresentationType = PresentationType.randomCase()
    private let router: BirthdayRouter!
    
    init(router: BirthdayRouter) {
        self.router = router
    }
}

extension BirthdayPresenter: BirthdayViewOutput {
    func viewDidLoad() {
        view?.configWithPresentation(type: currentPresentationType)
    }
}
