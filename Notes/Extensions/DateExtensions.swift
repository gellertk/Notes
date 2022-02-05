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
        switch self {
        case _ where Calendar.current.isDateInToday(self):
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: self)
        case _ where Calendar.current.isDateInYesterday(self):
            return "Вчера"
        case _ where Calendar.current.isDateInYesterday(self - 86400):
            return "Позавчера"
        default:
            formatter.dateFormat = "dd.MM.yyyy"
            return formatter.string(from: self)
        }
    }
    
}
