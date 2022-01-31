//
//  ViewController.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 30.01.2022.
//

import UIKit

class NoteListViewController: UIViewController {
    
    let notes = Note.getStoredNotes()
    
    private lazy var notesTableView: UITableView = {
        let tableView = NoteListTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NoteListTableViewCell.self, forCellReuseIdentifier: Note.Constants.cellId)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupNavigationController()
        view.backgroundColor = .black
        [notesTableView].forEach { newView in
            newView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(newView)
        }
        setupConstraints()
    }
    
    private func setupNavigationController() {
        guard let navigationController = navigationController else {
            return
        }
        title = Note.Constants.noteTitle
        navigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationController.navigationBar.barStyle = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem?.tintColor = .systemOrange

        navigationController.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func didTapAddButton() {
  
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            notesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            notesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            notesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            notesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
    }
    
}

extension NoteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Note.Constants.cellId, for: indexPath) as? NoteListTableViewCell else {
            return UITableViewCell()
        }

        cell.updateLabels(notes[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}


