//
//  WelcomePresenter.swift
//  BabyBirthday
//
//  Created by Nikolay on 9/22/20.
//  Copyright © 2020 Nikolay. All rights reserved.
//

import UIKit

final class WelcomePresenter {
    weak var view: WelcomeViewInput?
        
    // MARK: - Private
    
    private let currentPresentationType = PresentationType.randomCase()
    private let router: WelcomeRouter!
    
    // MARK: - Init
    
    init(router: WelcomeRouter) {
        self.router = router
    }
}

extension WelcomePresenter: WelcomeViewOutput {
    func didTapShowBirthdayWith(name: String, birthday: String, photo: UIImage?) {
        
    }
    
    func viewDidLoad() {
        view?.configWithPresentation(type: currentPresentationType)
    }
    
    func didSelect(photo: UIImage?) {
        
    }
}
