//
//  Note.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 31.01.2022.
//

import Foundation

struct Note {
    
    struct Constants {
        static let cellId = "cellId"
        static let noteTitle = "Заметки"
    }
    
    public var title: String
    public var text: String
    public var id: Int
    public var date: Date
    private static var idFactory = 0

    init(title: String, text: String, date: Date) {
        self.title = title
        self.text = text
        self.date = date
        self.id = Note.getUniqueId()
    }
    
    private static func getUniqueId() -> Int {
        idFactory += 1
        return idFactory
    }
    
    public static func getStoredNotes() -> [Note] {
        return [
            Note(title: "Welcome", text: "This is the first note", date: Date()),
            Note(title: "Welcome", text: "This is the first note", date: Date()),
            Note(title: "Welcome", text: "This is the first note", date: Date()),
            Note(title: "Welcome", text: "This is the first note", date: Date()),
            Note(title: "Welcome", text: "This is the first note", date: Date()),

        ]
    }
    
    
}
