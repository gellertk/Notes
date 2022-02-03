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
    
}
