//
//  WelcomeViewController.swift
//  BabyBirthday
//
//  Created by Nikolay on 9/22/20.
//  Copyright © 2020 Nikolay. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imagePhotoView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var showBirtdayButton: UIButton!
    
    // MARK: - Variables
    
    var presenter: WelcomeViewOutput?
    private var imagePicker: ImagePicker?
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTextFields()
        configButton()
        configDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// MARK: - Actions

extension WelcomeViewController {
    @objc func didChangeText(textField: UITextField) {
        configButton()
    }
    
    @IBAction func showBirthdayTapped() {
        guard let nameText = nameTextField.text else { return }

        if nameText.isEmpty {
            let alert = UIAlertController(title: "Sorry",
                                          message: "Fill name",
                                          preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default))
            present(alert, animated: true, completion: nil)
        } else {
            presenter?.didTapShowBirthday()
        }
    }
    
    @IBAction func dateChanged(datePicker: UIDatePicker) {
        presenter?.changed(birthday: datePicker.date)
    }
    
    @IBAction func makePhotoTapped(button: UIButton) {
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        imagePicker?.present(from: showBirtdayButton)
    }
}

// MARK: - Private

private extension WelcomeViewController {
    func configTextFields() {
        nameTextField.addTarget(self, action: #selector(didChangeText(textField:)), for: .editingChanged)
        nameTextField.text = presenter?.babyName()
    }
    
    func configButton() {
        showBirtdayButton.alpha = nameTextField.text?.isEmpty == true ? 0.2 : 1
    }
    
    func configDatePicker() {
        guard let presenter = presenter else { return }
        
        datePicker.maximumDate = presenter.maxDateForDatePicker()
        datePicker.minimumDate = presenter.minDateForDatePicker()
        datePicker.date = presenter.babyBirthday()
    }
    
    func configImageViewWith(type: PresentationType) {
        if let image = presenter?.babyPhoto() {
            imagePhotoView.image = image
        } else {
            imagePhotoView.image = type.iconPlacehoderCamera
        }
        
        imagePhotoView.layer.cornerRadius = imagePhotoView.frame.width / 2
    }
}

// MARK: - WelcomeViewInput

extension WelcomeViewController: WelcomeViewInput {
    func configWithPresentation(type: PresentationType) {
        view.backgroundColor = type.color
        cameraButton.setBackgroundImage(type.iconCamera, for: .normal)
        configImageViewWith(type: type)
    }
}

// MARK: - UITextFieldDelegate

extension WelcomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            presenter?.changed(name: updatedText)
            return updatedText.count <= 20
        }
        
        return false
    }
}

// MARK: - ImagePickerDelegate

extension WelcomeViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?, imageUrl: NSURL?) {
        imagePhotoView.image = image
        presenter?.didSelect(photo: image)
    }
}
