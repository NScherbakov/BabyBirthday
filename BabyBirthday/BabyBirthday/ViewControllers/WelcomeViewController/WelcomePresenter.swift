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
    let currentPresentationType = PresentationType.randomCase()
    
}

extension WelcomePresenter: WelcomeViewOutput {
    func didTapShowBirthdayWith(name: String, birthday: String, photo: UIImage?) {
        
    }
    
    func viewDidLoad() {
        view?.configWithPresentation(type: currentPresentationType)
    }
}
