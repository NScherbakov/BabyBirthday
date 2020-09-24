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
    
    @IBOutlet weak var babeNameLabel: UILabel!
    @IBOutlet weak var babeAgeLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var numberImageView: UIImageView!
    
    // MARK: - Variables
    
    var presenter: BirthdayViewOutput?
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configNumberImageView()
        configLabels()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// MARK: - Actions

extension BirthdayViewController {
    @IBAction func closeTapped() {
        presenter?.closeTapped()
    }
}

// MARK: - Private

private extension BirthdayViewController {
    func configNumberImageView() {
        numberImageView.image = presenter?.imageForNumberImageView()
    }
    
    func configLabels() {
        babeNameLabel.text = presenter?.babyName()
        babeAgeLabel.text = presenter?.babyAge()
    }
}

// MARK: - BirthdayViewInput

extension BirthdayViewController: BirthdayViewInput {
    func configWithPresentation(type: PresentationType) {
        view.backgroundColor = type.color
        backgroundImageView.image = type.screenImage
    }
}
