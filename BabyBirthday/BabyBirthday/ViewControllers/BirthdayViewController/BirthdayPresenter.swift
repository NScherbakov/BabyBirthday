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
    
    func closeTapped() {
        router.dismiss()
    }
    
    func photo() -> UIImage? {
        guard let imageName = StorageService.readBabyPhotoUrl() else { return nil }
        
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
        guard let url = url, let photo = photo else { return }
        
        let imageName = url.lastPathComponent!
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        let localPath = documentDirectory.appendingPathComponent(imageName)

        let data = NSData(data: photo.pngData()!)
        data.write(toFile: localPath, atomically: true)
        
        StorageService.storageBabyPhoto(url: url.lastPathComponent!)
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
