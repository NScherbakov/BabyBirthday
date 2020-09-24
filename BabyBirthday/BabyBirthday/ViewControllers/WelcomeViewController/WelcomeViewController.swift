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
    private var datePicker: DatePicker?
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configTextFields()
        configButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        guard let nameText = nameTextField.text, let birhdayText = birhdayTextField.text else {
            return
        }
        
        if nameText.isEmpty && birhdayText.isEmpty {
            let alert = UIAlertController(title: "Sorry", message: "Fill all fields please",
                                          preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default))
            present(alert, animated: true, completion: nil)
        } else {
            presenter?.didTapShowBirthday()
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
        guard let presenter = presenter else { return }
        
        nameTextField.addTarget(self, action: #selector(didChangeText(textField:)), for: .editingChanged)
        
        let commonToolbar = CommonToolbar()
        commonToolbar.toolbarDelegate = self
        commonToolbar.update()
        
        let minDate = presenter.minDateForDatePicker()
        let maxDate = presenter.maxDateForDatePicker()
        let currentDate = presenter.babyBirthday()
        
        datePicker = DatePicker(minDate: minDate,
                                maxDate: maxDate,
                                currentDate: currentDate) { [weak self] date in
                                    
            guard let strongSelf = self else { return }
            strongSelf.configBirthdayTextFieldWith(date: date)
        }
   
        birhdayTextField.inputView = datePicker!.datePicker
        birhdayTextField.inputAccessoryView = commonToolbar
        
        birhdayTextField.text = presenter.babyBirthday()?.babyBirthdayString()
        nameTextField.text = presenter.babyName()
    }
    
    func configButton() {
        guard let nameText = nameTextField.text, let birhdayText = birhdayTextField.text else {
            return
        }
        
        let isEnabled = !nameText.isEmpty && !birhdayText.isEmpty
        showBirtdayButton.alpha = isEnabled ? 1 : 0.2
    }
    
    func configImageViewWith(type: PresentationType) {
        if let image = presenter?.babyPhoto() {
            imagePhotoView.image = image
        } else {
            imagePhotoView.image = type.iconPlacehoderCamera
        }
    }
    
    func configBirthdayTextFieldWith(date: Date?) {
        presenter?.changed(birthday: date)
        birhdayTextField.text = date?.babyBirthdayString()
        configButton()
    }
}

// MARK: - WelcomeViewInput

extension WelcomeViewController: WelcomeViewInput {
    func defaultPhotoImage() -> UIImage? {
        
        return nil
    }
    
    func configWithPresentation(type: PresentationType) {
        view.backgroundColor = type.color
        cameraButton.setBackgroundImage(type.iconCamera, for: .normal)
        configImageViewWith(type: type)
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTextField {
            presenter?.changed(name: nameTextField.text)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == birhdayTextField {
            return false
        }
        
        return true
    }
}

// MARK: - ImagePickerDelegate

extension WelcomeViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?, imageUrl: NSURL?) {
        imagePhotoView.image = image
        presenter?.didSelect(photo: image, by: imageUrl)
    }
}

// MARK: - CommonToolbarDelegate

extension WelcomeViewController: CommonToolbarDelegate {
    func commonToolbarCancelTapped(_ view: CommonToolbar) {
        birhdayTextField.text = ""
        self.view.endEditing(true)
        configButton()
    }
    
    func commonToolbarDoneTapped(_ view: CommonToolbar) {
        if birhdayTextField.text?.isEmpty == true {
            configBirthdayTextFieldWith(date: datePicker?.datePicker.date)
        }
        self.view.endEditing(true)
    }
}
