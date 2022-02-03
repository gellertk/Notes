//
//  ViewController.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 30.01.2022.
//

import UIKit

public var noteList: [Note] = []

class NoteListViewController: UIViewController {
    
    private static let noteTitle = "Заметки"
    
    private lazy var notesTableView: UITableView = {
        let tableView = NoteListTableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationController()
        getNotesFromStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        notesTableView.reloadData()
    }
    
    private func getNotesFromStorage() {
        noteList = CoreDataManager.shared.getNotes()
        //notesTableView.reloadData()
    }
    
    private func setupView() {
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
        title = NoteListViewController.noteTitle
        navigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationController.navigationBar.barStyle = .black
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                         style: .plain,
                                                         target: self,
                                                         action: #selector(didTapAddButton)), animated: false)
        navigationItem.rightBarButtonItem?.tintColor = .systemOrange
        navigationController.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func didTapAddButton() {
        guard let navigationController = navigationController else {
            return
        }
        createNote()
        navigationController.pushViewController(NoteViewController(), animated: true)
    }
    
    private func createNote() -> Note {
        let note = CoreDataManager.shared.createNote()
        noteList.insert(note, at: 0)
        notesTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        return note
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
        return noteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteListTableViewCell.cellId,
                                                       for: indexPath) as? NoteListTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(noteList[indexPath.row],
                   isFirst: indexPath.row == 0,
                   isLast: indexPath.row == (noteList.count - 1))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NoteListTableViewCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController = navigationController else {
            return
        }
        notesTableView.deselectRow(at: indexPath, animated: true)
        navigationController.pushViewController(NoteViewController(note: noteList[indexPath.row]), animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            noteList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteListTableViewCell.cellId,
                                                       for: indexPath) as? NoteListTableViewCell else {
            return
        }
        cell.setupCorners(isFirst: indexPath.row == 0,
                              isLast: indexPath.row == (noteList.count - 1))
    }
    
}
