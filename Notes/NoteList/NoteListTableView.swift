//
//  NotesTableView.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 01.02.2022.
//

import UIKit

class NoteListTableView: UITableView {
        
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    init() {
        super.init(frame: CGRect.zero, style: .plain)
        setupTableView()
    }
    
    private func setupTableView() {
        register(NoteListTableViewCell.self, forCellReuseIdentifier: NoteListTableViewCell.cellId)
        separatorStyle = .none
        backgroundColor = .black.withAlphaComponent(0.1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
