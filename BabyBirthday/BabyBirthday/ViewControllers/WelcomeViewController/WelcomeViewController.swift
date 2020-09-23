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
    @IBOutlet weak var birhdayTextField: UITextField!
    @IBOutlet weak var imagePhotoView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var showBirtdayButton: UIButton!
    
    // MARK: - Variables
    
    var presenter: WelcomeViewOutput?
    private var imagePicker: ImagePicker?
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configTextFields()
        configButton()
        
        DispatchQueue.main.async {
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

// MARK: - Actions

extension WelcomeViewController {
    @objc func didChangeText(textField: UITextField) {
        configButton()
    }
    
    @IBAction func showBirthdayTapped() {
        guard let nameText = nameTextField.text, let birhdayText = birhdayTextField.text else {
            return
        }
        
        if nameText.isEmpty && birhdayText.isEmpty {
            let alert = UIAlertController(title: "Sorry", message: "Fill all fields",
                                          preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in }))
            present(alert, animated: true, completion: nil)
        } else {
            
        }
    }
    
    @IBAction func makePhotoTapped(button: UIButton) {
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        imagePicker?.present(from: self.showBirtdayButton)
    }
}

// MARK: - Private

private extension WelcomeViewController {
    func configTextFields() {
        nameTextField.addTarget(self, action: #selector(didChangeText(textField:)), for: .editingChanged)
        
        let commonToolbar = CommonToolbar()
        commonToolbar.toolbarDelegate = self
        commonToolbar.update()
        
        birhdayTextField.inputView = DatePicker().datePicker
        birhdayTextField.inputAccessoryView = commonToolbar
    }
    
    func configButton() {
        guard let nameText = nameTextField.text, let birhdayText = birhdayTextField.text else {
            return
        }
        
        let isEnabled = !nameText.isEmpty && !birhdayText.isEmpty
        showBirtdayButton.alpha = isEnabled ? 1 : 0.2
    }
}

// MARK: - WelcomeViewInput

extension WelcomeViewController: WelcomeViewInput {
    func configWithPresentation(type: PresentationType) {
        view.backgroundColor = type.color
        cameraButton.setBackgroundImage(type.iconCamera, for: .normal)
        imagePhotoView.image = type.iconPlacehoderCamera
    }
    
    func updateNameTextField(text: String?) {
        nameTextField.text = text
    }
    
    func updateBirthdayTextField(text: String?) {
        birhdayTextField.text = text
    }
    
    func update(photo: UIImage?) {
        imagePhotoView.image = photo
    }
}

// MARK: - UITextFieldDelegate

extension WelcomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            birhdayTextField.becomeFirstResponder()
        } else {
            birhdayTextField.resignFirstResponder()
        }
        
        return true
    }
}

// MARK: - ImagePickerDelegate

extension WelcomeViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        imagePhotoView.image = image
    }
}

// MARK: - CommonToolbarDelegate

extension WelcomeViewController: CommonToolbarDelegate {
    func commonTooldarCancelTapped(_ view: CommonToolbar) {
        view.endEditing(true)
    }
    
    func commonTooldarDoneTapped(_ view: CommonToolbar) {
        view.endEditing(true)
    }
}

