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
    @IBOutlet weak var logoStackView: UIStackView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    
    // MARK: - Variables
    
    var presenter: BirthdayViewOutput?
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configNumberImageView()
        configLabels()
        configButton()
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
    
    func configButton() {
        shareButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
}

// MARK: - BirthdayViewInput

extension BirthdayViewController: BirthdayViewInput {
    func configWithPresentation(type: PresentationType) {
        backgroundImageView.image = type.screenImage
        photoButton.setBackgroundImage(type.iconCamera, for: .normal)
    }
    
    // Workaround for less than iPhone X size
    // Because this (small) background image doesn't have AppLogo at the bottom
    // i am not quite sure need i to do it?
    
    func showBottomAppLogo(at position: PresentationType.Position) {
        logoStackView.isHidden = false
        switch position {
        case .left:
            logoStackView.alignment = .leading
        case .right:
            logoStackView.alignment = .trailing
        case .center:
            logoStackView.alignment = .center
        }
    }
}
