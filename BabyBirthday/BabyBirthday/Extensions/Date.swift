//
//  Date.swift
//  BabyBirthday
//
//  Created by Nikolay on 9/23/20.
//  Copyright © 2020 Nikolay. All rights reserved.
//

import Foundation

extension Date {
    func babyBirthdayString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
    
    static func -(recent: Date, previous: Date) -> (month: Int?, day: Int?, year: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let year = Calendar.current.dateComponents([.year], from: previous, to: recent).year
        
        return (month: month, day: day, year: year)
    }
}
