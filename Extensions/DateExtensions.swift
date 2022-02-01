//
//  File.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 01.02.2022.
//

import Foundation

extension Date {
    
    func convertToHumanReadableFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: self)
    }

}
