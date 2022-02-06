//
//  ViewController.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 30.01.2022.
//

import UIKit

protocol NoteListViewControllerDelegate: AnyObject {
    func refreshNoteList()
    func deleteNote(note: Note)
}

class NoteListViewController: UIViewController {
    
    private var noteList: [Note] = []
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.searchTextField.backgroundColor = .clear
        return searchController
    }()
    
    private lazy var noteListTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 10
        tableView.register(NoteListTableViewCell.self, forCellReuseIdentifier: Constants.cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black.withAlphaComponent(0.1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillNotes()
        setupView()
    }
    
    private func fillNotes() {
        if UserDefaults.isFirstLaunch() {
            let welcomeNote = createNote()
            welcomeNote.text = Constants.firstNoteText
        } else {
            noteList = CoreDataManager.shared.getNotes()
        }
    }
    
    private func setupView() {
        view.backgroundColor = .black
        view.addSubview(noteListTableView)
        setupNavigationBar()
        setupConstraints()
    }
    
    private func setupNavigationBar() {
        guard let navigationController = navigationController else {
            return
        }
        title = Constants.noteTitle
        navigationItem.searchController = searchController
        navigationController.navigationBar.clipsToBounds = true
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = Constants.buttonsColor
        navigationController.navigationBar.isTranslucent = false
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                         style: .plain,
                                                         target: self,
                                                         action: #selector(didTapAddButton)), animated: false)
    }
    
    @objc private func didTapAddButton() {
        toNoteViewController(note: createNote())
    }
    
    private func createNote() -> Note {
        let note = CoreDataManager.shared.createNote()
        noteList.insert(note, at: 0)
        noteListTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        return note
    }
    
    private func toNoteViewController(note: Note) {
        guard let navigationController = navigationController else {
            return
        }
        let noteViewController = NoteViewController(note: note)
        noteViewController.noteListViewControllerDelegate = self
        navigationController.pushViewController(noteViewController, animated: true)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            noteListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            noteListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            noteListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            noteListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
    
    private func indexForNote(note: Note, in list: [Note]) -> IndexPath {
        let row = Int(list.firstIndex(where: { $0 == note }) ?? 0)
        return IndexPath(row: row, section: 0)
    }
    
}

extension NoteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId,
                                                       for: indexPath) as? NoteListTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(noteList[indexPath.row],
                   isFirst: indexPath.row == 0,
                   isLast: indexPath.row == (noteList.count - 1))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        noteListTableView.deselectRow(at: indexPath, animated: true)
        toNoteViewController(note: noteList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteNote(note: noteList[indexPath.row])
        }
    }
    
    func search(_ text: String?) {
        noteList = CoreDataManager.shared.getNotes(filter: text)
        noteListTableView.reloadData()
    }
    
}

extension NoteListViewController: NoteListViewControllerDelegate {
    
    func deleteNote(note: Note) {
        let indexPath = indexForNote(note: note, in: noteList)
        noteList.remove(at: indexForNote(note: note, in: noteList).row)
        noteListTableView.deleteRows(at: [indexPath], with: .automatic)
        CoreDataManager.shared.deleteNote(note)
    }
    
    func refreshNoteList() {
        noteList = noteList.sorted { $0.lastUpdated > $1.lastUpdated }
        noteListTableView.reloadData()
    }
    
}

extension NoteListViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText == "" ? nil : searchText
        search(text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(searchBar.text)
    }
    
}
