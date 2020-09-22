//
//  WelcomeProtocols.swift
//  BabyBirthday
//
//  Created by Nikolay on 9/22/20.
//  Copyright © 2020 Nikolay. All rights reserved.
//

import UIKit

protocol WelcomeViewOutput: class {
    func viewDidLoad()
    func didTapShowBirthdayWith(name: String, birthday: String, photo: UIImage?)
}

protocol WelcomeViewInput: class {
    func configWithPresentation(type: PresentationType)
    func updateNameTextField(text: String?)
    func updateBirthdayTextField(text: String?)
    func update(photo: UIImage?)
}
