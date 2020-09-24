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
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var logoStackView: UIStackView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    
    // MARK: - Variables
    
    var presenter: BirthdayViewOutput?
    private var imagePicker: ImagePicker?
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configNumberImageView()
        configLabels()
        configButton()
        configPhotoImageView()
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
    
   @IBAction func makePhotoTapped(button: UIButton) {
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        imagePicker?.present(from: button)
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
    
    func configPhotoImageView() {
        photoImageView.layer.cornerRadius = 120
        if let image = presenter?.photo() {
            photoImageView.image = image
        }
    }
}

// MARK: - BirthdayViewInput

extension BirthdayViewController: BirthdayViewInput {
    func configWithPresentation(type: PresentationType) {
        backgroundImageView.image = type.screenImage
        photoImageView.image = type.iconPlacehoderCamera
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

// MARK: - ImagePickerDelegate

extension BirthdayViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?, imageUrl: NSURL?) {
        photoImageView.image = image
        presenter?.didSelect(photo: image, by: imageUrl)
    }
}
