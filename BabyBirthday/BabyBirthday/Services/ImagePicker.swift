//
//  ImagePicker.swift
//  BabyBirthday
//
//  Created by Nikolay on 9/23/20.
//  Copyright © 2020 Nikolay. All rights reserved.
//

import UIKit

protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?, imageUrl: NSURL?)
}

class ImagePicker: NSObject {

    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?

    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()
        self.presentationController = presentationController
        self.delegate = delegate
        
        super.init()
    
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
    }
    
    func present(from sourceView: UIView) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let action = action(for: .camera, title: "Take a photo") {
            alertController.addAction(action)
        }
        
        if let action = action(for: .photoLibrary, title: "Select from gallery") {
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.pruneNegativeWidthConstraints()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        
        presentationController?.present(alertController, animated: true)
    }
}

// MARK: - Private

private extension ImagePicker {
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    private func pickerController(_ controller: UIImagePickerController,
                                  didSelect image: UIImage?,
                                  url: NSURL?) {
        controller.dismiss(animated: true, completion: nil)
        
        delegate?.didSelect(image: image, imageUrl: url)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension ImagePicker: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        pickerController(picker, didSelect: nil, url: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage,
            let url = info[.imageURL] as? NSURL else {
            return pickerController(picker, didSelect: nil, url: nil)
        }
        pickerController(picker, didSelect: image, url: url)
    }
}

extension ImagePicker: UINavigationControllerDelegate { }

// WorkAround - sometimes bug on iOS https://forums.swift.org/t/swift-3-to-swift-5-uiimagepickercontroller/36640/4
extension UIAlertController {
    func pruneNegativeWidthConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}
