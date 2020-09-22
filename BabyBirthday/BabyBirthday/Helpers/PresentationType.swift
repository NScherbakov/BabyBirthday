//
//  PresentationType.swift
//  BabyBirthday
//
//  Created by Nikolay on 9/22/20.
//  Copyright © 2020 Nikolay. All rights reserved.
//

import UIKit

enum PresentationType: CaseIterable {
    case fox
    case bird
    case elephant
    
    var color: UIColor {
        switch self {
        case .fox:
            return UIColor(red: 198/255, green: 232/255, blue: 223/255, alpha: 1)
        case .bird:
            return UIColor(red: 119/255, green: 241/255, blue: 246/255, alpha: 1)
        case .elephant:
            return UIColor(red: 249/255, green: 240/255, blue: 216/255, alpha: 1)
        }
    }
    
    var iconCamera: UIImage? {
        switch self {
        case .fox:
            return UIImage(named: "Camera_icon_green")
        case .bird:
            return UIImage(named: "Camera_icon_blue")
        case .elephant:
            return UIImage(named: "Camera_icon_yellow")
        }
    }
    
    var iconPlacehoderCamera: UIImage? {
        switch self {
        case .fox:
            return UIImage(named: "Placeholder_camera_green")
        case .bird:
            return UIImage(named: "Placeholder_camera_blue")
        case .elephant:
            return UIImage(named: "Placeholder_camera_yellow")
        }
    }
    
    static func randomCase() -> PresentationType {
        return PresentationType.allCases[Int(arc4random_uniform(UInt32(PresentationType.allCases.count)))]
    }
}
