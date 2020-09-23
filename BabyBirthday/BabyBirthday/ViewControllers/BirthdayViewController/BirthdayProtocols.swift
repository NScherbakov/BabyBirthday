//
//  BirthdayProtocols.swift
//  BabyBirthday
//
//  Created by Nikolay on 9/24/20.
//  Copyright © 2020 Nikolay. All rights reserved.
//

import Foundation

protocol BirthdayViewOutput: class {
    func viewDidLoad()
}

protocol BirthdayViewInput: class {
    func configWithPresentation(type: PresentationType)
}
