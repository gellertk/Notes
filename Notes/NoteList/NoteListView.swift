//
//  NoteListView.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 31.01.2022.
//

import UIKit

protocol NoteListViewDelegate: AnyObject {
    func addNewNote()
    func updateNavigationController()
}

class NoteListView: UIView {
    
    weak var delegate: NoteListViewDelegate?
    
//    private struct Constants {
//        static let cellId = "cellId"
//    }
//    
////    private lazy var addNoteButton: UIButton = {
////        let button = UIButton(type: .contactAdd)
////        button.addTarget(self, action: #selector(didTapAddNoteButton(sender:)), for: .touchUpInside)
////        return button
////    }()
//    
//    private lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
//        label.textColor = .white
//        label.text = "Заметки"
//        return label
//    }()
//    
//    private lazy var notesTableView: UITableView = {
//        let tableView = UITableView()
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellId)
//        return tableView
//    }()
//    
//    init() {
//        super.init(frame: CGRect.zero)
//        setupView()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    @objc private func didTapAddButton(sender: UIButton) {
//        
//    }
//    
//    private func setupView() {
//        backgroundColor = .black
//        translatesAutoresizingMaskIntoConstraints = false
//        [titleLabel, notesTableView].forEach { view in
//            view.translatesAutoresizingMaskIntoConstraints = false
//            addSubview(view)
//        }
//        setupConstraints()
//    }
//    
//    private func setupNavigationController() {
//        
//    }
//    
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
//            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            
//            notesTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
//            notesTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            notesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            notesTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
//        ])
//    }
}

extension NoteListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
