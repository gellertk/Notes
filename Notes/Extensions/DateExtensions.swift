//
//  File.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 01.02.2022.
//

import Foundation

extension Date {
    
    func convertToHumanReadableFormat() -> String {
        let formatter = DateFormatter()
        if Calendar.current.isDateInToday(self) {
            formatter.dateFormat = "hh:mm"
        } else {
            formatter.dateFormat = "dd.mm.yyyy"
        }
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: self)
    }
    
}
