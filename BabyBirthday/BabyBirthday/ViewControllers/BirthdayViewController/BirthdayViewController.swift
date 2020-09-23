//
//  BirthdayViewController.swift
//  BabyBirthday
//
//  Created by Nikolay on 9/24/20.
//  Copyright © 2020 Nikolay. All rights reserved.
//

import UIKit

final class BirthdayViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    // MARK: - Variables
    
    var presenter: BirthdayViewOutput?
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

// MARK: - BirthdayViewInput

extension BirthdayViewController: BirthdayViewInput {
    func configWithPresentation(type: PresentationType) {
        view.backgroundColor = type.color
        backgroundImageView.image = type.screenImage
    }
}
