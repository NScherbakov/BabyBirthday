//
//  CommonToolbar.swift
//  BabyBirthday
//
//  Created by Nikolay on 9/22/20.
//  Copyright © 2020 Nikolay. All rights reserved.
//

import UIKit

protocol CommonToolbarDelegate: class {
    func commonToolbarDoneTapped(_ view: CommonToolbar)
    func commonToolbarCancelTapped(_ view: CommonToolbar)
}

class CommonToolbar: UIToolbar {
    weak var toolbarDelegate: CommonToolbarDelegate?
    
    func update() {
        self.barStyle = .black
        self.isTranslucent = true
        self.tintColor = .white
        self.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "Clear", style: .done, target: self, action: #selector(onCancelTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onDoneTapped))
        self.setItems([cancelButton, spaceButton, doneButton], animated: false)
        self.isUserInteractionEnabled = true
    }
    
    @objc fileprivate func onDoneTapped() {
        self.toolbarDelegate?.commonToolbarDoneTapped(self)
    }
    
    @objc fileprivate func onCancelTapped() {
        self.toolbarDelegate?.commonToolbarCancelTapped(self)
    }
}
