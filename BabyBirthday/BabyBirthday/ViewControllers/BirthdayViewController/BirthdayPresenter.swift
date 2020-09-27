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

// MARK: - BirthdayViewOutput

extension BirthdayPresenter: BirthdayViewOutput {
    func viewDidLoad() {
        view?.configWithPresentation(type: currentPresentationType)
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
            if year > 1 {
                return "YEARS OLD!"
            }
            return "YEAR OLD!"
        } else if let month = dates.month {
            if month > 1 {
                return "MONTHS OLD!"
            }
            return "MONTH OLD!"
        }
        
        return ""
    }
    
    func closeTapped() {
        router.dismiss()
    }
    
    func photo() -> UIImage? {
        let imageName = ImageName.baby
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        
        if let dirPath = paths.first {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageURL.path)
        }
        
        return nil
    }
    
    func didSelect(photo: UIImage?, by url: NSURL?) {
        guard let photo = photo else { return }
        
        let imageName = ImageName.baby
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        let localPath = documentDirectory.appendingPathComponent(imageName)

        let data = NSData(data: photo.pngData()!)
        data.write(toFile: localPath, atomically: true)
        
        StorageService.storageBabyPhoto(url: imageName)
    }
    
    func shareTapped(in content: UIView) {
        view?.elementsForScreenshoot(hide: true)
        
        UIGraphicsBeginImageContext(content.frame.size)
        content.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        view?.elementsForScreenshoot(hide: false)
        view?.showShare(image: image)
    }
}
