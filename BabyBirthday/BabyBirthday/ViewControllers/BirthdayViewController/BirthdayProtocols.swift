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
    func photo() -> UIImage?
    func babyName() -> String?
    func babyAge() -> String?
    func closeTapped()
    func didSelect(photo: UIImage?, by url: NSURL?)
    func shareTapped(in content: UIView)
}

protocol BirthdayViewInput: class {
    func configWithPresentation(type: PresentationType)
    func elementsForScreenshoot(hide: Bool)
    func showShare(image: UIImage?)
}
