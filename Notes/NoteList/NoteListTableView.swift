//
//  NotesTableView.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 01.02.2022.
//

import UIKit

class NoteListTableView: UITableView {
        
    init() {
        super.init(frame: CGRect.zero, style: .plain)
        setupTableView()
    }
    
    private func setupTableView() {
        layer.cornerRadius = 10
        register(NoteListTableViewCell.self, forCellReuseIdentifier: NoteListTableViewCell.cellId)
        separatorStyle = .none
        backgroundColor = .black.withAlphaComponent(0.1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
