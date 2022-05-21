//
//  Int+Extensions.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 21.05.2022.
//

import Foundation

extension Int {
    
    func inclineEnding() -> String {
        switch (self % 10) {
        case 0:
            return "заметок"
        case 5...9:
            return "заметок"
        case 1:
            return "заметка"
        case 2...4:
            return "заметки"
        default:
            return ""
        }
    }
    
}
