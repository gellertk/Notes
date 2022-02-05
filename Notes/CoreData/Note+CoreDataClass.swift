//
//  Note+CoreDataClass.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 03.02.2022.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    
    var title: String {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? ""
    }
    
    var desc: String {
        var lines = text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).filter { $0 != "" }
        if lines.count > 0 {
            lines.removeFirst()
        }
        return "\(lastUpdated.convertToHumanReadableFormat()) \(lines.first ?? "Нет дополнительного текста")"
    }
    
}
