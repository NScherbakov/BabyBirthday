//
//  CommonToolbar.swift
//  BabyBirthday
//
//  Created by Nikolay on 9/22/20.
//  Copyright © 2020 Nikolay. All rights reserved.
//

import UIKit

protocol CommonToolbarDelegate: class {
    func commonTooldarDoneTapped(_ view: CommonToolbar)
    func commonTooldarCancelTapped(_ view: CommonToolbar)
}

class CommonToolbar: UIToolbar {
    weak var toolbarDelegate: CommonToolbarDelegate?
    
    func update() {
        self.barStyle = .black
        self.isTranslucent = true
        self.tintColor = .white
        self.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(onCancelTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onDoneTapped))
        self.setItems([cancelButton, spaceButton, doneButton], animated: false)
        self.isUserInteractionEnabled = true
    }
    
    @objc fileprivate func onDoneTapped() {
        self.toolbarDelegate?.commonTooldarDoneTapped(self)
    }
    
    @objc fileprivate func onCancelTapped() {
        self.toolbarDelegate?.commonTooldarDoneTapped(self)
    }
}
