//
//  ViewController.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 30.01.2022.
//

import UIKit

class NoteListViewController: UIViewController {
    
    var notes = Note.getStoredNotes()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
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
        guard let navigationController = navigationController else {
            return
        }
        navigationController.pushViewController(NoteViewController(), animated: true)
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
        
        cell.setupCell(notes[indexPath.row],
                       isFirst: indexPath.row == 0,
                       isLast: indexPath.row == (notes.count - 1))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController = navigationController else {
            return
        }
        notesTableView.deselectRow(at: indexPath, animated: true)
        navigationController.pushViewController(NoteViewController(note: notes[indexPath.row]), animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Note.Constants.cellId, for: indexPath) as? NoteListTableViewCell else {
            return
        }
        cell.setupCellCorners(isFirst: indexPath.row == 0,
                       isLast: indexPath.row == (notes.count - 1))
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Note.Constants.cellId, for: indexPath) as? NoteListTableViewCell else {
            return
        }
        cell.setupCellCorners(isFirst: indexPath.row == 0,
                       isLast: indexPath.row == (notes.count - 1))
    }
    
}


