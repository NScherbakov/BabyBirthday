//
//  BirthdayPresenter.swift
//  BabyBirthday
//
//  Created by Nikolay on 9/24/20.
//  Copyright © 2020 Nikolay. All rights reserved.
//

import UIKit

final class BirthdayPresenter {
    weak var view: BirthdayViewInput?
    
    // MARK: - Variables
    
    private let currentPresentationType = PresentationType.randomCase()
    private let router: BirthdayRouter!
    
    init(router: BirthdayRouter) {
        self.router = router
    }
}

// MARK: - Private

private extension BirthdayPresenter {
    var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
}

// MARK: - BirthdayViewOutput

extension BirthdayPresenter: BirthdayViewOutput {
    func viewDidLoad() {
        view?.configWithPresentation(type: currentPresentationType)
        
        if !hasTopNotch {
            view?.showBottomAppLogo(at: currentPresentationType.position)
        }
    }
    
    func imageForNumberImageView() -> UIImage? {
        guard let birthday = StorageService.readBabyBirthday() else {
            return nil
        }
        
        let dates = Date() - birthday
        if let year = dates.year, year > 0 {
            if let month = dates.month, month - (year * 12) == 6 {
                return UIImage(named: "1_half")
            } else {
                return UIImage(named: "\(year)")
            }
        } else if let month = dates.month {
            return UIImage(named: "\(month)")
        }
        
        return nil
    }
    
    func babyName() -> String? {
        guard let name = StorageService.readBabyName() else { return nil }
        
        return "today \(name) is".uppercased()
    }
    
    func babyAge() -> String? {
        guard let birthday = StorageService.readBabyBirthday() else {
            return nil
        }
        
        let dates = Date() - birthday
        if let year = dates.year, year > 0 {
            return "YEARS OLD!"
        } else {
            return "MONTH OLD!"
        }
    }
    
    func defaultPhotoImage() -> UIImage? {
        return currentPresentationType.iconPlacehoderCamera
    }
    
    func closeTapped() {
        router.dismiss()
    }
}
