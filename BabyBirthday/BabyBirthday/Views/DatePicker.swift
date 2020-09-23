//
//  DatePicker.swift
//  BabyBirthday
//
//  Created by Nikolay on 9/22/20.
//  Copyright © 2020 Nikolay. All rights reserved.
//

import UIKit

final class DatePicker: NSObject {

    let datePicker = UIDatePicker()
    var completion: ((Date?) -> Void)?
    
    init(minDate: Date? = .none,
         maxDate: Date? = .none,
         currentDate: Date? = .none,
         completion: ((Date?) -> Void)? = .none) {
        self.completion = completion
        super.init()
        self.setupWith(maxDate: maxDate, minDate: minDate, currentDate: currentDate)
    }
}

// MARK: - Private

private extension DatePicker {
    func setupWith(maxDate: Date?, minDate: Date?, currentDate: Date?) {
        datePicker.date = currentDate ?? Date()
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerChoosedDate), for: .valueChanged)
    }
}

// MARK: - Actions

extension DatePicker {
    @objc func datePickerChoosedDate() {
        completion?(datePicker.date)
    }
}
