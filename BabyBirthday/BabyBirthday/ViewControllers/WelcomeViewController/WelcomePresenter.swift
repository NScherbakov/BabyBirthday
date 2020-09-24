//
//  WelcomePresenter.swift
//  BabyBirthday
//
//  Created by Nikolay on 9/22/20.
//  Copyright © 2020 Nikolay. All rights reserved.
//

import UIKit
import Photos

final class WelcomePresenter {
    weak var view: WelcomeViewInput?
        
    // MARK: - Private
    
    private let maxYearsOld = 12
    private let currentPresentationType = PresentationType.randomCase()
    private let router: WelcomeRouter!
    
    // MARK: - Init
    
    init(router: WelcomeRouter) {
        self.router = router
    }
    
    var docmentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}

// MARK: - WelcomeViewOutput

extension WelcomePresenter: WelcomeViewOutput {
    func didTapShowBirthday() {
        router.showBirthday()
    }
    
    func viewDidLoad() {
        view?.configWithPresentation(type: currentPresentationType)
    }
    
    func viewWillAppear() {
        view?.configWithPresentation(type: currentPresentationType)
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
    
    func changed(name: String?) {
        StorageService.storageBaby(name: name)
    }
    
    func changed(birthday: Date?) {
        StorageService.storageBaby(birthday: birthday)
    }
    
    func maxDateForDatePicker() -> Date {
        return Date()
    }
    
    func babyName() -> String? {
        return StorageService.readBabyName()
    }
    
    func babyBirthday() -> Date? {
        return StorageService.readBabyBirthday()
    }
    
    func babyPhoto() -> UIImage? {
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
    
    func minDateForDatePicker() -> Date {
        let date = Calendar.current.date(byAdding: .year, value: -maxYearsOld, to: Date())
        return date ?? Date()
    }
}
