//
//  NotesTableView.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 01.02.2022.
//

import UIKit

class NoteListTableView: UITableView {
    
    private lazy var notesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Note.Constants.cellId)
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    init() {
        super.init(frame: CGRect.zero, style: .plain)
        setupView()
    }
    
    private func setupView() {
        separatorStyle = .none
        backgroundColor = .black.withAlphaComponent(0.1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
