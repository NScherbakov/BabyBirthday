//
//  WelcomeProtocols.swift
//  BabyBirthday
//
//  Created by Nikolay on 9/22/20.
//  Copyright © 2020 Nikolay. All rights reserved.
//

import UIKit

protocol WelcomeViewOutput: class {
    func viewWillAppear()
    func didTapShowBirthday()
    
    func maxDateForDatePicker() -> Date
    func minDateForDatePicker() -> Date
    
    func changed(name: String?)
    func changed(birthday: Date?)
    func didSelect(photo: UIImage?)
    
    func babyName() -> String?
    func babyBirthday() -> Date
    func babyPhoto() -> UIImage?
}

protocol WelcomeViewInput: class {
    func configWithPresentation(type: PresentationType)
}
