//
//  BirthdayProtocols.swift
//  BabyBirthday
//
//  Created by Nikolay on 9/24/20.
//  Copyright © 2020 Nikolay. All rights reserved.
//

import UIKit

protocol BirthdayViewOutput: class {
    func viewDidLoad()
    func imageForNumberImageView() -> UIImage?
    func babyName() -> String?
    func babyAge() -> String?
    func closeTapped()
}

protocol BirthdayViewInput: class {
    func configWithPresentation(type: PresentationType)
}
